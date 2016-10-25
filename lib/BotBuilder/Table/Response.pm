package BotBuilder::Table::Response;

use Moo;
use HTML::TableContent::Template;
with 'BotBuilder::Table::Role::DBIC';
with 'BotBuilder::Table::Role::Catalyst';

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
    text => 'Quotes Table',
    link => sub { $_[0]->ctx->link('create') },
    inner_html => ['<h2>%s</h2><a href="%s" class="btn btn-info table-button" role="button">Create</a>', 'text', 'get_first_link']
);

header id => (
    text => 'Troll Id',
    sort => 1,
);

header text => (
    search => 1,
    sort => 1,
);

header feedback => (
    search => 1,
    sort => 1,
);

header contact_id => (
    sort => 1,
);

header program_message_id => (
    sort => 1,
);

header recieved => (
    search => 1,
    sort => 1,
);

1;
