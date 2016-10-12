use strict;
use warnings;
 
package Catalyst::View::Template::Pure;
 
use Catalyst::View::Template::Pure::Response;
use Scalar::Util qw/blessed refaddr weaken/;
use Catalyst::Utils;
use HTTP::Status ();
use File::Spec;
use Mojo::DOM58;
use Template::Pure::ParseUtils;
use Template::Pure::DataContext;
 
use base 'Catalyst::View';
 
our $VERSION = '0.011';
 
sub COMPONENT {
  my ($class, $app, $args) = @_;
  $args = $class->merge_config_hashes($class->config, $args);
  $args = $class->modify_init_args($app, $args) if $class->can('modify_init_args');
  $class->inject_http_status_helpers($args);
  $class->load_auto_template($app, $args);
  $class->find_fields;

  return bless $args, $class;
}
 
my @fields;
sub find_fields {
  my $class = shift;
  for ($class->meta->get_all_attributes) {
    next unless $_->has_init_arg;
    push @fields, $_->init_arg;
  }
}
 
sub load_auto_template {
  my ($class, $app, $args) = @_;
  my @parts = split("::", $class);
  my $filename = lc(pop @parts);
   
  if(delete $args->{auto_template_src}) {
    my $file = $app->path_to('lib', @parts, $filename.'.html');
    my $contents = $file->slurp;
    my $dom = Mojo::DOM58->new($contents);
    if(my $node = $dom->at('pure-component')) {
      if(my $script_node = $node->at('script')) {
        $class->config(script => "$script_node");
        $script_node->remove('script');
      }
      if(my $style_node = $node->at('style')) {
        $class->config(style => "$style_node");
        $style_node->remove('style');
      }
      $contents = $node->content;
    }
    $class->config(template => $contents);
  }
  if(delete $args->{auto_script_src}) {
    my $file = $app->path_to('lib', @parts, $filename.'.js');
    $class->config(script => $file->slurp);    
  }
  if(delete $args->{auto_style_src}) {
    my $file = $app->path_to('lib', @parts, $filename.'.css');
    $class->config(style => $file->slurp);    
  }
}
 
sub inject_http_status_helpers {
  my ($class, $args) = @_;
  return unless $args->{returns_status};
  foreach my $helper( grep { $_=~/^http/i} @HTTP::Status::EXPORT_OK) {
    my $subname = lc $helper;
    my $code = HTTP::Status->$helper;
    my $codename = "http_".$code;
    if(grep { $code == $_ } @{ $args->{returns_status}||[]}) {
       eval "sub ${\$class}::${\$subname} { return shift->response(HTTP::Status::$helper,\@_) }";
       eval "sub ${\$class}::${\$codename} { return shift->response(HTTP::Status::$helper,\@_) }";
    }
  }
}
 
sub ACCEPT_CONTEXT {
  my ($self, $c, @args) = @_;
 
  my %args = ();
  if(scalar(@args) % 2) {
    my $proto = shift @args;
    # TODO This needs to enforce the duck type
    foreach my $field (@fields) {
      if(my $cb = $proto->can($field)) {
        $args{$field} = $proto->$field;
      }
    }
  }
 
  %args = (%args, @args);
  my $args = $self->merge_config_hashes($self->config, \%args);
  $args = $self->modify_context_args($c, $args) if $self->can('modify_context_args');
  $self->handle_request($c, %$args) if $self->can('handle_request');
 
  my $template;
  if(exists($args->{template})) {
    $template = delete ($args->{template});
  } elsif(exists($args->{template_src})) {
    $template = (delete $args->{template_src})->slurp;
  } else {
    die "Can't find a template for your View";
  }
 
  my $directives = delete $args->{directives};
  my $filters = delete $args->{filters};
  my $pure_class = exists($args->{pure_class}) ?
    delete($args->{pure_class}) :
    'Template::Pure';
 
  Catalyst::Utils::ensure_class_loaded($pure_class);
 
  my $key = blessed($self) ? refaddr($self) : $self;
 
  if(blessed $c) {
 
    my $stash_key = "__Pure_${key}";
 
    if(my $clear = delete($args{clear_stash})) {
      delete $c->stash->{$stash_key};
    }
 
    weaken $c;
    $c->stash->{$stash_key} ||= do {
 
      ## TODO Could we not optimize by building this just once per application
      ## scope?
 
      my $view = ref($self)->new(
        %{$args},
        %{$c->stash},
        ctx => $c,
      );
 
      weaken(my $weak_view = $view);
      my $pure = $pure_class->new(
        template => $template,
        directives => $directives,
        filters => $filters,
        components => $self->build_comp_hash($c, $view),
        view => $weak_view,
        %$args,
      );
 
      $view->{pure} = $pure;
      $view;
    };
    return $c->stash->{$stash_key};
  } else {
    die "Can't make this class without a context";
  }
}
 
sub build_comp_hash {
  my ($self, $c, $view) = @_;
  return $self->{__components} if $self->{__components};
  my %components = (
    map {
      my $v = $_;
      my $key = lc($v);
      $key =~s/::/-/g;
      $key => sub {
        my ($pure, %params) = @_;
        my $data = Template::Pure::DataContext->new($view);
        foreach $key (%{$params{node}->attr ||+{}}) {
          next unless $key && $params{$key};
          next unless my $proto = ($params{$key} =~m/^\$(.+)$/)[0];
          my %spec = Template::Pure::ParseUtils::parse_data_spec($proto);
          $params{$key} = $data->at(%spec)->value;
        }
 
        return $c->view($v, %params, clear_stash=>1);
      }
    } ($c->views),
  );
  $self->{__components} = \%components;
  return \%components;
}
 
sub apply {
  my $self = shift;
  my @args = (@_,
    template => $self->render,
    %{$self->{ctx}->stash});
  return $self->{ctx}->view(@args);
}
 
sub wrap {
  my $self = shift;

  my @args = (@_,
    content => $self->render,
    %{$self->{ctx}->stash});
  return $self->{ctx}->view(@args);
}
 
sub response {
  my ($self, $status, @proto) = @_;
  die "You need a context to build a response" unless $self->{ctx};
 
  my $res = $self->{ctx}->res;
  $status = $res->status if $res->status != 200;
 
  if(ref($proto[0]) eq 'ARRAY') {
    my @headers = @{shift @proto};
    $res->headers->push_header(@headers);
  }
 
  $res->content_type('text/html') unless $res->content_type;
  my $body = $res->body($self->render);
 
  my $response = bless +{
    ctx => $self->{ctx},
    content => $body,
  }, 'Catalyst::View::Template::Pure::Response';
 
  return $response;
}
 
sub render {
  my ($self, $data) = @_;
  $self->{ctx}->stats->profile(begin => "=> ".Catalyst::Utils::class2classsuffix($self->catalyst_component_name)."->Render");
 
  # quite possible I should do something with $data...
  my $string = $self->{pure}->render($self);
  $self->{ctx}->stats->profile(end => "=> ".Catalyst::Utils::class2classsuffix($self->catalyst_component_name)."->Render");
  return $string;
}
 
sub TO_HTML {
  my ($self, $pure, $dom, $data) = @_;
  return $self->{pure}->encoded_string(
    $self->render($self));
}
 
sub Views {
  my $self = shift;
  my %views = (
    map {
      my $v = $_;
      $v => sub {
        my ($pure, $dom, $data) = @_;
        # TODO $data can be an object....
        $self->{ctx}->view($v, %$data);
      }
    } ($self->{ctx}->views)
  );
  return \%views;
}
 
# Proxy these here for now.  I assume eventually will nee
# a subclass just for components
#sub prepare_render_callback { shift->{pure}->prepare_render_callback }
 
sub prepare_render_callback {
  my $self = shift;
  return sub {
    my ($t, $dom, $data) = @_;
    $self->{pure}->process_root($dom->root, $data);
    $t->encoded_string($self->render($data));
  };
}
 
sub style_fragment { shift->{pure}->style_fragment }
sub script_fragment { shift->{pure}->script_fragment }
sub ctx { return shift->{ctx} }
 
sub process {
  my ($self, $c, @args) = @_;
  $self->response(200, @args);
}
 
sub headers { 
  # TODO let you add headders
}
1;

