use utf8;
package BotBuilder::Schema::Result::Bot;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BotBuilder::Schema::Result::Bot

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

=head1 TABLE: C<bots>

=cut

__PACKAGE__->table("bots");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'bots_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 troll_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 program_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 active

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 created

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 updated

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "bots_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "troll_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "program_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "active",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "created",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "updated",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 bot_integrations

Type: has_many

Related object: L<BotBuilder::Schema::Result::BotIntegration>

=cut

__PACKAGE__->has_many(
  "bot_integrations",
  "BotBuilder::Schema::Result::BotIntegration",
  { "foreign.bot_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program

Type: belongs_to

Related object: L<BotBuilder::Schema::Result::Program>

=cut

__PACKAGE__->belongs_to(
  "program",
  "BotBuilder::Schema::Result::Program",
  { id => "program_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 troll

Type: belongs_to

Related object: L<BotBuilder::Schema::Result::Troll>

=cut

__PACKAGE__->belongs_to(
  "troll",
  "BotBuilder::Schema::Result::Troll",
  { id => "troll_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-26 10:41:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7Zh6+8eguoh3JDabKut/rw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
