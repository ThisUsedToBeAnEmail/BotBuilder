use strict;
use warnings;

use BotBuilder;

my $app = BotBuilder->apply_default_middlewares(BotBuilder->psgi_app);
$app;

