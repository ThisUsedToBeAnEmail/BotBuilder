package BotBuilder::Form::Message::Text;
 
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
    default => q{text},
);

has_field 'text' => ( 
    type=> 'Text', 
    required => 1
);

has_field 'submit' => (
    type => 'Submit',
);
    
sub update_model {
    my $self = shift;
    
    my $item = $self->item;
    my $content = to_json({ text => $self->field('text')->value });

    $item->template_type($self->template_type);
    $item->content($content);
    $item->update_or_insert;
}

__PACKAGE__->meta->make_immutable;
1;
