package BotBuilder::Controller;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }
with 'Catalyst::Controller::Role::Link';

__PACKAGE__->meta->make_immutable;

1;
