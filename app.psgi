use strict;
use warnings;
use lib 'lib';
use BotBuilder;
use Plack::Builder;

builder {
    enable_if { $_[0]->{HTTP_X_FORWARDED_FOR} }
        "Plack::Middleware::ReverseProxy";
    BotBuilder->psgi_app;
}; 


