package BotBuilder::Controller::SlackBot;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::SlackBot;
use BotBuilder::Table::SlackBot;

sub base :Chained('/') :PathPart('slack_bot') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::SlackBot'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::SlackBot->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'slack_bot/list.tt');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $slack_bot = $c->stash->{resultset}->new_result({});
    return $self->form($c, $slack_bot);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('slack_bot') {
    my ($self, $c, $id) = @_;

    $c->stash(slack_bot => $c->stash->{resultset}->find($id));
    die "slack_bot $id not found!" unless $c->stash->{slack_bot};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{slack_bot}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{slack_bot});
}

sub form {
    my ($self, $c, $slack_bot) = @_;

    my $form = BotBuilder::Form::SlackBot->new(
        id => $slack_bot->id,
    );
        
    $c->stash( form => $form, template => 'slack_bot/form.tt' );
    $form->process( item => $slack_bot, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
