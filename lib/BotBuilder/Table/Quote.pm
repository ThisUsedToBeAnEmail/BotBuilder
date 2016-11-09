package BotBuilder::Table::Quote;

use Moo;
use HTML::TableContent::Template;
with 'HTML::TableContent::Template::Javascript';
with 'HTML::TableContent::Template::DBIC';
with 'HTML::TableContent::Template::Catalyst';
with 'HTML::TableContent::Template::Catalyst::Util';

sub table_spec {
    return {
        class => 'table table-hover',
        html5 => 1,
        wrap_html => ['<div class="table-responsive">%s</div>'],
        pagination => 1,
        display => 10,
        search_text => 'Search Quotes..',
        create => {
            caption => {
                method => 'catalyst',
                text => 'Add new Quote',
            },
        },
        update => {
            row => {
                method => 'catalyst',
                text => 'Edit',
                link => sub { $_[0]->ctx->link('edit', [$_[0]->id->get_last_cell->text]) },
            },
        },
        delete => {
            row => { 
                method => 'catalyst',
                text => 'Delete',
                link => sub { $_[0]->ctx->link('delete', [$_[0]->id->get_last_cell->text]) },
            },
        },
    };
}

caption title => (
    text => 'Quotes Table',
    link => sub { $_[0]->ctx->link('create') },
    inner_html => [
        '<h1 class="page-header">%s</h1>', 
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

=pod
header edit => (
    special => 1,
    text => '',
    cells => {
        text => 'Edit',
        link =>  sub { $_[0]->ctx->link('edit', [$_[0]->id->get_last_cell($_[1]->row_index)->text]) },
        inner_html => [
            '<a href="%s" class="btn btn-info table-button" role="button">%s</a>',
            'get_first_link', 
            'text'
        ]
    }
);

header delete => (
    special => 1,
    text => '',
    cells => {
        text => 'Delete',
        link =>  sub { $_[0]->ctx->link('delete', [$_[0]->id->get_last_cell->text]) },
        inner_html => [
            '<a href="%s" class="btn btn-danger table-button" role="button">%s</a>',
            'get_first_link', 
            'text'
        ]
    }
);
=cut
1;
