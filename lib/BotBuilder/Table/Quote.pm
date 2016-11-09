package BotBuilder::Table::Quote;

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
        search_text => 'Search Quotes..',
    };
}

caption title => (
    text => 'Quotes Table',
    link => sub { $_[0]->ctx->link('create') },
    inner_html => [
        '<h1 class="page-heading">%s</h1>', 
    ],
    buttons => [
        {
            method => 'catalyst',
            text => 'Create',
            class => 'btn caption-button btn-success',
            link => sub { return $_[0]->ctx->link('create'); }, 
        },
    ]
);

header id => (
    text => 'Troll Id',
    sort => 1,
);

header troll_id => (
    filter => 1,
    sort => 1,
    relationship => 'troll',
    field => 'name',
    text => 'Troll Name'
);

header text => (
    search => 1,
    text => 'Quotes'
);

header edit => (
    special => 1,
    text => '',
    cells => {
        buttons => [
            {
                method => 'catalyst',
                text => 'Edit',
                class => 'btn row-button btn-warning',
                link =>  sub { $_[0]->ctx->link('edit', [$_[0]->id->get_last_cell($_[1]->row_index)->text]) },
            }
        ]
    }
);

header delete => (
    special => 1,
    text => '',
    cells => {
        buttons => [
            {
                method => 'catalyst',
                text => 'Delete',
                class => 'btn row-button btn-danger',
                link =>  sub { $_[0]->ctx->link('delete', [$_[0]->id->get_last_cell->text]) },
            }
        ]
    }
);

1;
