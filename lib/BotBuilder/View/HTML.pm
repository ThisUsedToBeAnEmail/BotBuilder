package BotBuilder::View::HTML;

use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    INCLUDE_PATH => [
        BotBuilder->path_to('root', 'templates' ),
    ],
    TIMER => 0,
    WRAPPER => 'wrapper.tt',
    render_die => 1,
);

1;
