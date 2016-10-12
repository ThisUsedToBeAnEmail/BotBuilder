package BotBuilder::View::FormTable;

use Moose;
use HTTP::Status qw(:constants);
use Catalyst::View::Template::Pure::Helpers (':All');

extends 'Catalyst::View::Template::Pure';

has [qw/message/] => (is => 'ro', required => 1);

sub current { scalar localtime }

__PACKAGE__->config(
  timestamp => scalar(localtime),
  returns_status => [HTTP_OK],
  template => q[
            <form class="" method="post" action="auth/login" name="formtable">         
                <span id="message"> </span>
            </form>
  ],
  directives => [
    '.' => Wrap('Wrapper'),
    '#message' => 'message',
  ],
);

__PACKAGE__->meta->make_immutable;

1;
