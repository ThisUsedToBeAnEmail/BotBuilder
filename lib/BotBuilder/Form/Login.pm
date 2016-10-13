package BotBuilder::Form::Login;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';
with 'BotBuilder::Form::Theme::Boot';

use namespace::autoclean;

has_field 'username' => (
    type => 'Text',
    label => 'Username',
    required => 1,
);

has_field 'password' => (
    type => 'Password',
    label => 'Password',
    required => 1,
);

has_field 'submit' => (
    type => 'Submit',
    value => 'Login',
);

__PACKAGE__->meta->make_immutable;

1;
