package BotBuilder::Table::Response;

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
    text => 'Response Table',
    inner_html => ['<h2>%s</h2>', 'text']
);

header id => (
    text => 'Response Id',
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
