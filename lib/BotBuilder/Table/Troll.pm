package BotBuilder::Table::Troll;

use Moo;
use HTML::TableContent::Template;

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

sub _data {
    return [
        {
            id => 1,
            name => 'Donald Trump',
            description => 'first'
        }
    ];
}

1;
