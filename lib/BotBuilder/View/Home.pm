package BotBuilder::View::Home;

use Moose;
use HTTP::Status qw(:constants);

extends 'Catalyst::View::Template::Pure';

has [qw/title body timestamp/] => (is => 'ro', required => 1);

sub current { scalar localtime }

__PACKAGE__->config(
  timestamp => scalar(localtime),
  returns_status => [HTTP_OK],
  template => q[
    <!doctype html>
    <html lang="en">
    <head>
        <title>Title Goes Here</title>
        <link href="static/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="static/css/cover.css" rel="stylesheet">
    </head>
    <body>
    <div class="site-wrapper">
      <div class="site-wrapper-inner">
        <div class="cover-container">
          <div class="masthead clearfix">
            <div class="inner">
              <h3 class="masthead-brand">Cover</h3>
              <nav class="nav nav-masthead">
                <a class="nav-link active" href="#">Home</a>
                <a class="nav-link" href="#">Features</a>
                <a class="nav-link" href="#">Contact</a>
              </nav>
            </div>
          </div>
          <div class="inner cover">
            <h1 class="cover-heading">Mehhhh BotBuilder.</h1>
            <p id="main"></p>
            <div id="current">Current Localtime: </div>
            <div id="timestamp">Server Started on: </div>
          </div>
          <div class="mastfoot">
            <div class="inner">
              <p>lnation</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    </body>
    </html>      
  ],
  directives => [
    'title' => 'title',
    '#main' => 'body',
    '#current+' => 'current',
    '#timestamp+' => 'timestamp',
  ],
);

__PACKAGE__->meta->make_immutable;

1;
