package BotBuilder::Table::Contact;

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
    text => 'Contact Table',
    link => sub { $_[0]->ctx->link('create') },
    inner_html => ['<h2>%s</h2><a href="%s" class="btn btn-info table-button" role="button">Create</a>', 'text', 'get_first_link']
);

header id => (
    text => 'Id',
    sort => 1,
);

header fb_id => (
    search => 1,
    sort => 1,
    text => 'FB ID'
);

header program_id => (
    search => 1,
    sort => 1,
    text => 'Program ID'
);

1;
