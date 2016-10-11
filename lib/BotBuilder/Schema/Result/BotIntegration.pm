use utf8;
package BotBuilder::Schema::Result::BotIntegration;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BotBuilder::Schema::Result::BotIntegration

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<bot_integrations>

=cut

__PACKAGE__->table("bot_integrations");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'bot_integrations_id_seq'

=head2 bot_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 fb_bot_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 slack_bot_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "bot_integrations_id_seq",
  },
  "bot_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "fb_bot_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "slack_bot_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 bot

Type: belongs_to

Related object: L<BotBuilder::Schema::Result::Bot>

=cut

__PACKAGE__->belongs_to(
  "bot",
  "BotBuilder::Schema::Result::Bot",
  { id => "bot_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 fb_bot

Type: belongs_to

Related object: L<BotBuilder::Schema::Result::FbBot>

=cut

__PACKAGE__->belongs_to(
  "fb_bot",
  "BotBuilder::Schema::Result::FbBot",
  { id => "fb_bot_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 slack_bot

Type: belongs_to

Related object: L<BotBuilder::Schema::Result::SlackBot>

=cut

__PACKAGE__->belongs_to(
  "slack_bot",
  "BotBuilder::Schema::Result::SlackBot",
  { id => "slack_bot_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 20:23:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:j36hf6qfp40EreDJpJEZ9Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
