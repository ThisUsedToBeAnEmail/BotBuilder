package BotBuilder::Controller::Program;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::Program;
use BotBuilder::Table::Program;

sub base :Chained('/') :PathPart('program') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::Program'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::Program->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'program/list.tt');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $program = $c->stash->{resultset}->new_result({});
    return $self->form($c, $program);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('program') {
    my ($self, $c, $id) = @_;

    $c->stash(program => $c->stash->{resultset}->find($id));
    die "program $id not found!" unless $c->stash->{program};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{program}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{program});
}

sub form {
    my ($self, $c, $program) = @_;

    my $form = BotBuilder::Form::Program->new(
        id => $program->id,
    );
        
    $c->stash( form => $form, template => 'program/form.tt' );
    $form->process( item => $program, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
