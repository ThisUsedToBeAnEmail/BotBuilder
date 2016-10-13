package BotBuilder::Controller::Troll;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::Troll;

sub base :Chained('/') :PathPart('troll') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::Troll'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(table => );
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $troll = $c->model('DB::Troll')->new_result({});
    return $self->form($c, $quote);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('troll') {
    my ($self, $c, $id) = @_;

    $c->stash(troll => $c->stash->{resultset}->find($id));
    die "troll $id not found!" unless $c->stash->{troll};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{troll}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{troll});
}

sub form {
    my ($self, $c, $quote) = @_;

    my $form = BotBuilder::Form::Troll->new(
        id => $quote->id,
    );
        
    $c->stash( form => $form );
    $form->process( item => $quote, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
