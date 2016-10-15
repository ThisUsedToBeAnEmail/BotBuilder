package BotBuilder::Table::Troll;

use Moo;
use HTML::TableContent::Template;
with 'BotBuilder::Table::Role::DBIC';

sub table_spec {
    return {
        class => 'table table-hover',
        html5 => 1,
        wrap_html => ['<div class="table-responsive">%s</div>'],
        pagination => 1,
        display => 5,
    };
}

caption title => (
    text => 'Troll Table',
    links => ['http://localhost:3000/troll/create'],
    inner_html => ['%s <a href="%s">Create</a>', 'text', 'get_first_link']
);

header id => (
    text => 'Troll Id',
);

header name => ();

header description => ();

1;
