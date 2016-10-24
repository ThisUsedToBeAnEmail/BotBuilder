package BotBuilder::Controller::Contact;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::Contact;
use BotBuilder::Table::Contact;

sub base :Chained('/') :PathPart('contact') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::Contact'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::Contact->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'contact/list.tt');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $contact = $c->stash->{resultset}->new_result({});
    return $self->form($c, $contact);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('contact') {
    my ($self, $c, $id) = @_;

    $c->stash(contact => $c->stash->{resultset}->find($id));
    die "contact $id not found!" unless $c->stash->{contact};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{contact}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{contact});
}

sub form {
    my ($self, $c, $contact) = @_;

    my $form = BotBuilder::Form::Contact->new(
        id => $contact->id,
    );
        
    $c->stash( form => $form, template => 'contact/form.tt' );
    $form->process( item => $contact, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
