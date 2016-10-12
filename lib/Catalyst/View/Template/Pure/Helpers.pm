use strict;
use warnings;
 
package Catalyst::View::Template::Pure::Helpers;
 
use Exporter 'import';
use Template::Pure::DataProxy;
 
our @EXPORT_OK = (qw/Uri Apply Wrap/);
our %EXPORT_TAGS = (All => \@EXPORT_OK, ALL => \@EXPORT_OK);
 
sub Uri {
  my ($path, @args) = @_;
  die "$path is not a string" unless ref \$path eq 'SCALAR';
  my ($controller_proto, $action_proto) = ($path=~m/^(.*)\.(.+)$/); 
  return sub {
    my ($pure, $dom, $data) = @_;
    my $c = $pure->{view}{ctx};
    my $controller;
    if($controller_proto) {
      die "$controller_proto is not a controler!" unless
        $controller = $c->controller($controller_proto);
    } else {
      # if not specified, use the current
      $controller = $c->controller;
    }
 
    die "$action_proto is not an action for controller ${\$controller->component_name}"
      unless my $action = $controller->action_for($action_proto);
 
    $data = Template::Pure::DataProxy->new(
      $data,
      captures => $c->request->captures || [],
      args => $c->request->args || [],
      query => $c->request->query_parameters|| +{});
 
    # We need to unroll the @args and fill in any template values.
    my $resolve = sub {
      my $arg = shift;
      if(my ($v) = ($arg=~m/^\=\{(.+)\}$/)) {
        return $pure->data_at_path($data,$v);
      } else {
        return $arg;
      }
    };
 
    # Change any placeholders.
    my @local_args = map {
      my $arg = $_;
      if(ref \$_ eq 'SCALAR') {
        $arg = $resolve->($arg);
      } elsif(ref $arg eq 'ARRAY') {
        $arg = [map { $resolve->($_) } @$arg];
      } elsif(ref $arg eq 'HASH') {
        $arg = +{map { my $val = $arg->{$_}; $resolve->($_) => $resolve->($val) } keys %$arg};
      }
      $arg;
    } @args;
 
    my $uri = $c->uri_for($action, @local_args);
    return $pure->encoded_string("$uri"); 
  };
}
 
sub Apply {
  my ($view_name, @args) = @_;
  return ['.' => sub {
    my ($pure, $dom, $data) = @_;
    my $c = $pure->{view}{ctx};
    return $c->view($view_name, $data, template=>$dom, clear_stash=>1, @args);
  }];
}
 
sub Wrap {
  my ($view_name, @args) = @_;
  return ['.' => sub {
    my ($pure, $dom, $data) = @_;
    my $c = $pure->{view}{ctx};
    return $c->view($view_name, $data, content=>$dom, clear_stash=>1, @args);
  }];
}
 
1;
