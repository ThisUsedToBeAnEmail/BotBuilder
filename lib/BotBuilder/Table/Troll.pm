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
    };
}

caption title => (
    text => 'Troll Table',
    inner_html => ['<h1 class="page-header">%s</h1>', 'text']
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
    onclick => ['window.location=\'%s\'', 'get_first_link']
);

around last_chance => sub {
    my ($orig, $self, $args) = @_;

    my $table = $self->$orig($args);

    my $caption = $table->caption;

    $caption->add_child({ 
        html_tag => 'a',
        link => sub { return $_[0]->ctx->link('create') },
        class => 'btn btn-info table-button', 
        role => 'button',
        text => 'Create' 
    });

    return $table;
};

1;
