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
    inner_html => ['<h1 class="page-heading">%s</h1>'],
    buttons => [
        {
            method => 'catalyst',
            text => 'Troll List',
            link => sub { $_[0]->ctx->link('/troll/list'); },
            class => 'btn caption-button btn-primary',
        },
        {
            method => 'catalyst',
            link => sub { return $_[0]->ctx->link('/troll/delete', [$_[0]->result->id]); },
            text => 'Delete Troll',
            class => 'btn caption-button btn-danger right',
        }
    ]   
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
