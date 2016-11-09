package BotBuilder::Table::Bot;

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
    text => 'Bot Table',
    link => sub { $_[0]->ctx->link('create') },
    inner_html => ['<h1 class="page-heading">%s</h1>'],
    buttons => [
        {
            method => 'catalyst',
            text => 'Add New Bot',
            class => 'btn caption-button btn-success',
            link => sub { $_[0]->ctx->link('create'); },
        }
    ]
);

header id => (
    text => 'Bot Id',
    sort => 1,
);

header name => (
    search => 1,
    sort => 1,
);

header description => (
    search => 1,
);

header troll_id => (
    sort => 1,
    relationship => 'troll',
    field => 'name',
    text => 'Troll',
    cells => {
        link => sub { return $_[0]->ctx->link('troll/quote/list', [$_[0]->id->get_last_cell->text, $_[1]->attributes->{original_text}]) },
        inner_html => ['<a href="%s">%s</a>', 'get_first_link', 'text']
    }
);

header program_id => (
    sort => 1,
    text => 'Program',
);

header active => (
    search => 1,
    sort => 1,
    filter => 1,
);

header created => (
    sort => 1,
);

header updated => (
    sort => 1
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
