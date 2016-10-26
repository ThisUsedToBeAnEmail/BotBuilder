package BotBuilder::Table::Bot;

use Moo;
use HTML::TableContent::Template;

with 'HTML::TableContent::Template::Javascript';
with 'HTML::TableContent::Template::DBIC';
with 'HTML::TableContent::Template::Catalyst';

sub table_spec {
    return {
        class => 'table table-hover',
        html5 => 1,
        wrap_html => ['<div class="table-responsive">%s</div>'],
        pagination => 1,
        display => 10,
    };
}

caption title => (
    text => 'Bot Table',
    link => sub { $_[0]->ctx->link('create') },
    inner_html => ['<h2>%s</h2><a href="%s" class="btn btn-info table-button" role="button">Create</a>', 'text', 'get_first_link']
);

header id => (
    text => 'Bot Id',
    sort => 1,
);

header name => (
    search => 1,
    sort => 1,
);

header description => (
    search => 1,
);

header troll_id => (
    sort => 1,
);

header program_id => (
    sort => 1,
);


header active => (
    search => 1,
    sort => 1,
    filter => 1,
);

header created => (
    sort => 1,
);

header updated => (
    sort => 1
);

1;
