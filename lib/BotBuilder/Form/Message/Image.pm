package BotBuilder::Form::Message::Image;
 
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;
use JSON;

has '+item_class' => ( default => 'Message' );

has 'id' => (
    is  => 'ro',
    isa => 'Maybe[Int]'
);

has 'template_type' => (
    is => 'ro',
    isa => 'Str',
    default => q{image},
);

has_field 'url' => ( 
    type=> 'Text', 
    required => 1
);

has_field 'submit' => (
    type => 'Submit',
);
    
sub update_model {
    my $self = shift;
    
    my $item = $self->item;
    my $content = {
        attachment => {
            type    =>  $self->template_type,
            payload =>  {
                url => $self->field('url')->value
            }
        }
    };

    $item->template_type($self->template_type);
    $item->content(to_json($content));
    $item->update_or_insert;
}

__PACKAGE__->meta->make_immutable;
1;
