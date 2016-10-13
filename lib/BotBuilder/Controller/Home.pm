package BotBuilder::Controller::Home;

use Moose;
use MooseX::MethodAttributes;

extends 'BotBuilder::Controller';

sub base :Chained('/') :PathPart('') :CaptureArgs(0) {}

sub home :Chained('base') :PathPart('home') Args(0) {
    my ($self, $c) = @_;
}

__PACKAGE__->meta->make_immutable;

1;
