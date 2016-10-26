package BotBuilder::Controller::Bot::Troll;

use Moose;
use namespace::autoclean;

BEGIN { extends 'BotBuilder::Controller::Troll'; }

use BotBuilder::Form::Troll;
use BotBuilder::Table::Troll;
use BotBuilder::Table::TrollInfo;

sub base :Chained('/bot/chain') :PathPart('troll') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $rs = $c->model('DB::Troll')->search({
        id => $c->stash->{bot}->troll_id
    });

    $c->stash(resultset => $c->model('DB::Troll'));
}

__PACKAGE__->meta->make_immutable;

1;
