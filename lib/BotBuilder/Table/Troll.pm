package BotBuilder::Table::Troll;

use Moo;
use HTML::TableContent::Template;
with 'BotBuilder::Table::Role::DBIC';

sub table_spec {
    return {
        id => 'some-table',
        class => 'table table-hover',
        html5 => 1,
        wrap_html => ['<div class="table-responsive">%s</div>']
    };
}

caption title => (
    text => 'Troll Table',
);

header id => (
    text => 'Troll Id',
);

header name => ();

header description => ();

1;
