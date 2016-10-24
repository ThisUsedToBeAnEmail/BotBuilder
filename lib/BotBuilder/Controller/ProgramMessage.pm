package BotBuilder::Controller::ProgramMessage;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::ProgramMessage;
use BotBuilder::Table::ProgramMessage;

sub base :Chained('/') :PathPart('program_message') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::ProgramMessage'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::ProgramMessage->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'program_message/list.tt');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $program_message = $c->stash->{resultset}->new_result({});
    return $self->form($c, $program_message);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('program_message') {
    my ($self, $c, $id) = @_;

    $c->stash(program_message => $c->stash->{resultset}->find($id));
    die "program_message $id not found!" unless $c->stash->{program_message};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{program_message}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{program_message});
}

sub form {
    my ($self, $c, $program_message) = @_;

    my $form = BotBuilder::Form::ProgramMessage->new(
        id => $program_message->id,
    );
        
    $c->stash( form => $form, template => 'program_message/form.tt' );
    $form->process( item => $program_message, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
