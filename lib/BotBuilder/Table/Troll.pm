package BotBuilder::Table::Troll;

use Moo;
use HTML::TableContent::Template;

with 'HTML::TableContent::Template::Catalyst';
with 'HTML::TableContent::Template::DBIC';
with 'HTML::TableContent::Template::Javascript';

sub table_spec {
    return {
        class => 'table table-hover',
        html5 => 1,
        wrap_html => ['<div class="table-responsive">%s</div>'],
        pagination => 1,
        display => 10,
        buttons => {
            caption => [
                {
                    method => 'catalyst',
                    link => sub { return $_[0]->ctx->link('create'); },
                    text => 'Add New Troll',
                    class => 'btn caption-button btn-success'
                },
            ],
            row => [
                {
                    method => 'catalyst',
                    text => 'Add New Quote',
                    class => 'btn row-button btn-success',
                    link => sub { return $_[0]->ctx->link('quote/create', [$_[0]->id->get_last_cell->text]); },
                    cell => {
                        width => '100px',
                    }
                },
                {
                    method => 'catalyst',
                    text => 'Update Troll',
                    class => 'btn row-button btn-warning',
                    link => sub { return $_[0]->ctx->link('edit', [$_[0]->id->get_last_cell->text]); },
                    cell => {
                        width => '100px',
                    }
                },
                {
                    method => 'catalyst',
                    text => 'Delete Troll',
                    class => 'btn row-button btn-danger',
                    link => sub { $_[0]->ctx->link('delete', [$_[0]->id->get_last_cell->text]) },
                    cell => {
                        width => '100px',
                    }
                },
            ],
        },
        update => {
            row =>
        }
    };
}

caption title => (
    text => 'Troll Table',
    inner_html => ['<h1 class="page-heading">%s</h1>', 'text']
);

header id => (
    text => 'Troll Id',
    sort => 1,
);

header name => (
    search => 1,
    sort => 1,
);

header description => (
    search => 1,
    sort => 1,
);

row all => (
    link => sub { return $_[0]->ctx->link('quote/list', [$_[1]->get_first_cell->text]); },
    onclick => ['window.location=\'%s\'', 'get_first_link'],
    class => 'link-row',
);

1;
