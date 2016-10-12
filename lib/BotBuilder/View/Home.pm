package BotBuilder::View::Home;

use Moose;
use HTTP::Status qw(:constants);

extends 'Catalyst::View::Template::Pure';

has [qw/body timestamp/] => (is => 'ro', required => 1);

sub current { scalar localtime }

__PACKAGE__->config(
  timestamp => scalar(localtime),
  returns_status => [HTTP_OK],
  template => q[
            <h1 class="cover-heading">Mehhhh BotBuilder.</h1>
            <p id="main"></p>
            <div id="current">Current Localtime: </div>
            <div id="timestamp">Server Started on: </div>
  ],
  directives => [
    '#main' => 'body',
    '#current+' => 'current',
    '#timestamp+' => 'timestamp',
  ],
);

__PACKAGE__->meta->make_immutable;

1;
