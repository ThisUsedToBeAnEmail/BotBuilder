package BotBuilder::Controller::BotType;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::BotType;
use BotBuilder::Table::BotType;

sub base :Chained('/') :PathPart('bot_type') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::BotType'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::BotType->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'bot_type/list.tt');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $bot_type = $c->stash->{resultset}->new_result({});
    return $self->form($c, $bot_type);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('bot_type') {
    my ($self, $c, $id) = @_;

    $c->stash(bot_type => $c->stash->{resultset}->find($id));
    die "bot_type $id not found!" unless $c->stash->{bot_type};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{bot_type}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{bot_type});
}

sub form {
    my ($self, $c, $bot_type) = @_;

    my $form = BotBuilder::Form::BotType->new(
        id => $bot_type->id,
    );
        
    $c->stash( form => $form, template => 'bot_type/form.tt' );
    $form->process( item => $bot_type, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
