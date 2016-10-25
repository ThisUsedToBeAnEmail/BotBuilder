package BotBuilder::Controller::FbBot;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::FbBot;
use BotBuilder::Table::FbBot;

sub base :Chained('/') :PathPart('fb_bot') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::FbBot'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::FbBot->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'fb_bot/list.tt');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $fb_bot = $c->stash->{resultset}->new_result({});
    return $self->form($c, $fb_bot);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('fb_bot') {
    my ($self, $c, $id) = @_;

    $c->stash(fb_bot => $c->stash->{resultset}->find($id));
    die "fb_bot $id not found!" unless $c->stash->{fb_bot};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{fb_bot}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{fb_bot});
}

sub form {
    my ($self, $c, $fb_bot) = @_;

    my $form = BotBuilder::Form::FbBot->new(
        id => $fb_bot->id,
    );
        
    $c->stash( form => $form, template => 'fb_bot/form.tt' );
    $form->process( item => $fb_bot, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
