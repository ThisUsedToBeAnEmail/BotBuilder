package BotBuilder::Controller::Auth;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base :Chained('/') :PathPart('auth') :Args('0') { }

sub login :Chained('base') :PathPart('login') :Args('0') {
     my ( $self, $c ) = @_;

     my $username = $c->req->params->{username};
     my $password = $c->req->params->{password};

     if ( $username && $password ) {
        if ( $c->authenticate({ username => $username, password => $password }) ) {
            $c->response->redirect($c->uri_for('/'));
         } else {
         }
      } else {
      }

      # template render
}

sub logout :Chained('base') :PathPart('logout') :Args('0') {
    my ( $self, $c ) = @_;

    $c->logout;

    $c->response->redirect($c->uri_for('/'));
}

__PACKAGE__->meta->make_immutable;

1;

