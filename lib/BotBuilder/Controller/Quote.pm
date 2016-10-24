package BotBuilder::Controller::Quote;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::Quote;
use BotBuilder::Table::Quote;

sub base :Chained('/') :PathPart('quote') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::Quote'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::Quote->new(rs => $c->stash->{resultset}, ctx => $c);
    
    use Data::Dumper;
    warn Dumper $table->render;
    $c->stash(table => $table);
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $quote = $c->stash->{resultset}->new_result({});
    return $self->form($c, $quote);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('quote') {
    my ($self, $c, $id) = @_;

    $c->stash(quote => $c->stash->{resultset}->find($id));
    die "quote $id not found!" unless $c->stash->{quote};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{quote}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{quote});
}

sub form {
    my ($self, $c, $quote) = @_;

    my $form = BotBuilder::Form::Quote->new(
        id => $quote->id,
    );
        
    $c->stash( form => $form );
    $form->process( item => $quote, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
