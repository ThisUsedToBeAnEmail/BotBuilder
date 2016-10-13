package BotBuilder::Controller::Auth;
use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::Login;

sub base :Chained('/') :PathPart('auth') :CaptureArgs('0') { }

sub login :Chained('base') :PathPart('login') :Args('0') {
     my ( $self, $c ) = @_;

    my $form = BotBuilder::Form::Login->new;
    $c->stash(form => $form);

    $form->process(params => $c->req->params);

    if ($form->validated) {
        my $param = $form->params;
        if ( $c->authenticate({ username => $param->{username}, password => $param->{password}}) ) {
            $c->response->redirect($c->uri_for('/home'));
        } else {
            $form->add_form_error('Invalid username or password');
        }
    }
}

sub logout :Chained('base') :PathPart('logout') :Args('0') {
    my ( $self, $c ) = @_;

    $c->logout;

    $c->response->redirect($c->uri_for('/'));
}

__PACKAGE__->meta->make_immutable;

1;

