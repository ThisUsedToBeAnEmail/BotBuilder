package BotBuilder::Controller::Home;

use Moose;
use MooseX::MethodAttributes;

extends 'Catalyst::Controller';

sub base :Chained('/') :PathPart('') :CaptureArgs(0) {}

sub home :Chained('base') :PathPart('home') Args(0) {
    my ($self, $c) = @_;
    $c->view('Home',
        body => 'Some Text.',
    )->wrap('Wrapper', title => 'something')->http_ok;
}

__PACKAGE__->meta->make_immutable;

1;
