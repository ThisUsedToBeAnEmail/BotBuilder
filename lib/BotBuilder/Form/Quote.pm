package BotBuilder::Form::Quote;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
with 'BotBuilder::Form::Theme::Boot';
use namespace::autoclean;

has '+item_class' => ( default => 'Quote' );

has_field 'troll_id' => (
    type => 'Select',
    label => 'Troll',
    required => 1
);

sub options_troll_id {
    my $self = shift;

    return unless $self->schema;
    my $troll_rs = $self->schema->resultset('Troll');
    my @trolls = map { { value => $_->id, label => $_->name } } $troll_rs->all;
    return @trolls;
}

has_field 'text' => (
    type => 'Text',
    required => 1
);

has_field 'submit' => (
    type => 'Submit',
    value => 'Submit'
);

__PACKAGE__->meta->make_immutable;

1;
