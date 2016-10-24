package BotBuilder::Form::ProgramMessage;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
with 'BotBuilder::Form::Theme::Boot';
use namespace::autoclean;

has '+item_class' => ( default => 'ProgramMessage' );

has_field 'message_id' => (
    type => 'Select',
    label => 'Message',
    required => 1
);

sub options_message_id {
    my $self = shift;

    return unless $self->schema;
    my $message_rs = $self->schema->resultset('Message');
    my @trolls = map { { value => $_->id, label => $_->content } } $message_rs->all;
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

has_field 'step' => (
    type => 'Text',
    required => 1
);

has_field 'launch_type' => (
    type => 'Select',
    label => 'Launch',
);

sub options_launch_type {
    return [
        { value => 'automatic', label => 'Send instantly' },
        { value => 'response', label => 'Wait for a response' },
        { value => 'schedule', label => 'Schedule a launch' }
    ];
}

has_field 'launch_time' => (
    type => 'Text',
);

has_field 'submit' => (
    type => 'Submit',
    value => 'Submit'
);

__PACKAGE__->meta->make_immutable;

1;
