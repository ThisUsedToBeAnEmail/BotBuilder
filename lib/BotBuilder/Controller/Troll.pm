package BotBuilder::Controller::Troll;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::Troll;
use BotBuilder::Table::Troll;
use BotBuilder::Table::TrollInfo;

sub base :Chained('/') :PathPart('troll') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::Troll'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::Troll->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table);
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $troll = $c->stash->{resultset}->new_result({});
    return $self->form($c, $troll);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('troll') {
    my ($self, $c, $id) = @_;

    my $troll = $c->stash->{resultset}->find($id);
    my $troll_info = BotBuilder::Table::TrollInfo->new(result => $troll, ctx => $c);
    $c->stash(troll => $troll, troll_info => $troll_info);
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

sub view :Chained('chain') :PathPart('view') :Args(0) {
    my ($self, $c) = @_;

}

sub form {
    my ($self, $c, $troll) = @_;

    my $form = BotBuilder::Form::Troll->new(
        id => $troll->id,
    );
        
    $c->stash( form => $form, template => 'quote/form.tt' );
    $form->process( item => $troll, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
