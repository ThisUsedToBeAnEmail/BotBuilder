package BotBuilder::Controller::BotIntegration;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller'; }

use BotBuilder::Form::BotIntegration;
use BotBuilder::Table::BotIntegration;

sub base :Chained('/') :PathPart('bot_integration') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash(resultset => $c->model('DB::BotIntegration'));
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $table = BotBuilder::Table::BotIntegration->new(rs => $c->stash->{resultset}, ctx => $c);
    
    $c->stash(table => $table, template => 'bot_integration/list.tt');
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;

    my $bot_integration = $c->stash->{resultset}->new_result({});
    return $self->form($c, $bot_integration);
}

sub chain :Chained('base') :PathPart('') :CaptureArgs(1) :Name('bot_integration') {
    my ($self, $c, $id) = @_;

    $c->stash(bot_integration => $c->stash->{resultset}->find($id));
    die "bot_integration $id not found!" unless $c->stash->{bot_integration};
}

sub delete :Chained('chain') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{bot_integration}->delete;
    $c->response->redirect($c->link('list'));
}

sub edit :Chained('chain') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    return $self->form($c, $c->stash->{bot_integration});
}

sub form {
    my ($self, $c, $bot_integration) = @_;

    my $form = BotBuilder::Form::BotIntegration->new(
        id => $bot_integration->id,
    );
        
    $c->stash( form => $form, template => 'bot_integration/form.tt' );
    $form->process( item => $bot_integration, params => $c->req->params );
    return unless $form->validated;

    $c->response->redirect($c->link('list'));
}

__PACKAGE__->meta->make_immutable;

1;
