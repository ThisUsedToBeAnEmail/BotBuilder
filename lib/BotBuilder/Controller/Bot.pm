package BotBuilder::Controller::Bot;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::Bot;
use BotBuilder::Table::Bot;

sub base :Chained('/') :PathPart('bot') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::Bot'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::Bot->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'bot/list.tt');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $bot = $c->stash->{resultset}->new_result({});
    return $self->form($c, $bot);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('bot') {
    my ($self, $c, $id) = @_;

    $c->stash(bot => $c->stash->{resultset}->find($id));
    die "bot $id not found!" unless $c->stash->{bot};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{bot}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{bot});
}

sub form {
    my ($self, $c, $bot) = @_;

    my $form = BotBuilder::Form::Bot->new(
        id => $bot->id,
    );
        
    $c->stash( form => $form, template => 'bot/form.tt' );
    $form->process( item => $bot, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
