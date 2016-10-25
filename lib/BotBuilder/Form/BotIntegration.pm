package BotBuilder::Form::BotIntegration;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
with 'BotBuilder::Form::Theme::Boot';
use namespace::autoclean;

has '+item_class' => ( default => 'Quote' );

has_field 'bot_id' => (
    type => 'Select',
    label => 'Bot',
    required => 1
);

sub options_bot_id {
    my $self = shift;

    return unless $self->schema;
    my $bot_rs = $self->schema->resultset('Bot');
    my @bots = map { { value => $_->id, label => $_->name } } $bot_rs->all;
    return @bots;
}

has_field 'fb_bot_id' => (
    type => 'Select',
    label => 'Fb Bot',
    required => 1
);

sub options_fb_bot_id {
    my $self = shift;

    return unless $self->schema;
    my $bot_rs = $self->schema->resultset('FbBot');
    my @bots = map { { value => $_->id, label => $_->name } } $bot_rs->all;
    return @bots;
}

has_field 'slack_bot_id' => (
    type => 'Select',
    label => 'Slack Bot',
    required => 1
);

sub options_slack_bot_id {
    my $self = shift;

    return unless $self->schema;
    my $bot_rs = $self->schema->resultset('FbBot');
    my @bots = map { { value => $_->id, label => $_->name } } $bot_rs->all;
    return @bots;
}

has_field 'submit' => (
    type => 'Submit',
    value => 'Submit'
);

__PACKAGE__->meta->make_immutable;

1;
