package BotBuilder::Controller::Bot::Troll::Quote;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller::Quote'; }

use BotBuilder::Form::Quote;
use BotBuilder::Table::Quote;

sub base :Chained('/bot/troll/chain') :PathPart('quote') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $rs = $c->model('DB::Quote')->search({
        troll_id => $c->stash->{troll}->id,
    });

    $c->stash(resultset => $rs);
}

__PACKAGE__->meta->make_immutable;

1;
