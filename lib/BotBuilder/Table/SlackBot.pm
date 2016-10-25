package BotBuilder::Table::SlackBot;

use Moo;
use HTML::TableContent::Template;
with 'BotBuilder::Table::Role::DBIC';
with 'BotBuilder::Table::Role::Catalyst';

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
    text => 'Slack Bot Table',
    link => sub { $_[0]->ctx->link('create') },
    inner_html => ['<h2>%s</h2><a href="%s" class="btn btn-info table-button" role="button">Create</a>', 'text', 'get_first_link']
);

header id => (
    text => 'Id',
    sort => 1,
);

header slack_hook => (
    search => 1,
    sort => 1,
);

header slack_channed => (
    search => 1,
    sort => 1,
);

1;
