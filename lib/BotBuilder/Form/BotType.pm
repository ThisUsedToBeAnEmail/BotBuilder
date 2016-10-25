package BotBuilder::Form::BotType;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
with 'BotBuilder::Form::Theme::Boot';
use namespace::autoclean;

has '+item_class' => ( default => 'Quote' );

has_field 'bot_type' => (
    type => 'Text',
    required => 1
);

has_field 'description' => (
    type => 'TextArea',
    required => 1
);

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

has_field 'program_id' => (
    type => 'Select',
    label => 'Program',
    required => 1
);

sub options_program_id {
    my $self = shift;

    return unless $self->schema;
    my $program_rs = $self->schema->resultset('Program');
    my @programs = map { { value => $_->id, label => $_->name } } $program_rs->all;
    return @programs;
}

has_field 'submit' => (
    type => 'Submit',
    value => 'Submit'
);

__PACKAGE__->meta->make_immutable;

1;
