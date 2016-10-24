package BotBuilder::Table::ProgramMessage;

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
    text => 'Program Message Table',
    link => sub { $_[0]->ctx->link('create') },
    inner_html => ['<h2>%s</h2><a href="%s" class="btn btn-info table-button" role="button">Create</a>', 'text', 'get_first_link']
);

header id => (
    text => 'Troll Id',
    sort => 1,
);

header message_id => (
    search => 1,
    sort => 1,
);

header program_id => (
    search => 1,
    sort => 1,
);

header step => (
    search => 1,
    sort => 1,
);

header launch_type => (
    search => 1,
    sort => 1,
);

header launch_time => (
    search => 1,
    sort => 1,
    text => 'Quotes'
);

1;
