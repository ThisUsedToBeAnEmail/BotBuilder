package MyApp::Form::Troll;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
with 'BotBuilder::Form::Theme::Boot';

use namespace::autoclean;

has '+item_class' => ( default => 'Troll' );

has_field 'name' => (
    type => 'Text',
    required => 1
);

has_field 'description' => (
    type => 'TextArea',
    required => 1
);

__PACKAGE__->meta->make_immutable;

1;
