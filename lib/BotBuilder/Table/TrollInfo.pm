package BotBuilder::Table::TrollInfo;

use Moo;
use HTML::TableContent::Template;

with 'HTML::TableContent::Template::Javascript';
with 'HTML::TableContent::Template::DBIC';
with 'HTML::TableContent::Template::Catalyst';

sub table_spec {
    return {
        class => 'table table-reflow',
        html5 => 1,
        wrap_html => ['<div class="table-responsive">%s</div>'],
        vertical => 1,
    };
}

caption title => (
    text => 'Troll',
    link => sub { return $_[0]->ctx->link('/troll/delete', [$_[0]->result->id]); },
    inner_html => ['<h2>%s</h2><a href="%s" class="btn btn-info table-button" role="button">Delete</a>', 'text', 'get_first_link']
);

header id => (
    text => 'Troll Id',
    scope => 'row',
);

header name => (
    scope => 'row',
);

header description => (
    scope => 'row',
);

1;
