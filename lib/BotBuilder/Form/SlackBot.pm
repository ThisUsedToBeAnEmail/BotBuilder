package BotBuilder::Form::SlackBot;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
with 'BotBuilder::Form::Theme::Boot';
use namespace::autoclean;

has '+item_class' => ( default => 'Program' );

has_field 'slack_hook' => (
    type => 'Text',
    required => 1
);

has_field 'slack_channel' => (
    type => 'Text',
    required => 1
);

has_field 'submit' => (
    type => 'Submit',
    value => 'Submit'
);

__PACKAGE__->meta->make_immutable;

1;
