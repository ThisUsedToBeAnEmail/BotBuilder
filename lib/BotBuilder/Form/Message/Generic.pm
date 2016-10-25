package BotBuilder::Form::Message::Generic;
 
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
    default => q{generic},
);

has_field 'title' => (
    type => 'Text',
    required => 1
);

has_field 'image_url' => (
    type => 'Text',
    required => 1
);

has_field 'subtitle' => (
    type    => 'Text',
    required => 1
);

has_field 'button_type' => (
    type => 'Text',
    required => 1,
);

has_field 'button_title' => (
    type     => 'Text',
    required => 1
);

has_field 'button_url' => ( 
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
            type    => 'template',
            payload => {
                template_type => $self->template_type,
                elements => [
                    {
                        title => $self->field('title')->value,
                        image_url => $self->field('image_url')->value,
                        subtitle => $self->field('subtitle')->value,
                        buttons => [
                            {
                                type  => $self->field('button_type')->value,
                                url   => $self->field('button_url')->value,
                                title => $self->field('button_title')->value,
                            }
                        ]
                    }   
                ]
            }
        }
    };

    $item->template_type($self->template_type);
    $item->content(to_json($content));
    $item->update_or_insert;
}

__PACKAGE__->meta->make_immutable;
1;
