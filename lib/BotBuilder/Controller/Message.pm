package BotBuilder::Controller::Message;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::Message;
use BotBuilder::Table::Message;

sub base :Chained('/') :PathPart('message') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::Message'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::Message->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'message/list.tt');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $message = $c->stash->{resultset}->new_result({});
    return $self->form($c, $message);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('message') {
    my ($self, $c, $id) = @_;

    $c->stash(message => $c->stash->{resultset}->find($id));
    die "message $id not found!" unless $c->stash->{message};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{message}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{message});
}

sub form {
    my ($self, $c, $message) = @_;

    my $form = BotBuilder::Form::Message->new(
        id => $message->id,
    );
        
    $c->stash( form => $form, template => 'message/form.tt' );
    $form->process( item => $message, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
