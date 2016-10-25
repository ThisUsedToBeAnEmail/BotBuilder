package BotBuilder::Form::Bot;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
with 'BotBuilder::Form::Theme::Boot';
use namespace::autoclean;

has '+item_class' => ( default => 'Quote' );

has_field 'bot_type_id' => (
    type => 'Select',
    label => 'Bot Type',
    required => 1
);

sub options_bot_type_id {
    my $self = shift;

    return unless $self->schema;
    my $types_rs = $self->schema->resultset('BotType');
    my @types = map { { value => $_->id, label => $_->name } } $types_rs->all;
    return @types;
}

has_field 'name' => (
    type => 'Text',
    required => 1
);

has_field 'slack_channel' => (
    type => 'Text',
    required => 1
);

has_field 'slack_hook' => (
    type => 'Text',
    required => 1
);

has_field 'fb_token' => (
    type => 'Text',
    required => 1
);

has_field 'active' => (
    type => 'Boolean',
    required => 1
);

has_field 'submit' => (
    type => 'Submit',
    value => 'Submit'
);

__PACKAGE__->meta->make_immutable;

1;
