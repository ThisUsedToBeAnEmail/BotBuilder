package BotBuilder::Controller::Response;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Table::Response;

sub base :Chained('/') :PathPart('response') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::Response'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::Response->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'response/list.tt');
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('response') {
    my ($self, $c, $id) = @_;

    $c->stash(response => $c->stash->{resultset}->find($id));
    die "response $id not found!" unless $c->stash->{response};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{response}->delete;
    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
