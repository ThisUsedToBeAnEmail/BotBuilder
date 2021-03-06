use utf8;
package BotBuilder::Schema::Result::Program;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BotBuilder::Schema::Result::Program

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

=head1 TABLE: C<programs>

=cut

__PACKAGE__->table("programs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'programs_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 created

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "programs_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "created",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 bots

Type: has_many

Related object: L<BotBuilder::Schema::Result::Bot>

=cut

__PACKAGE__->has_many(
  "bots",
  "BotBuilder::Schema::Result::Bot",
  { "foreign.program_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contacts

Type: has_many

Related object: L<BotBuilder::Schema::Result::Contact>

=cut

__PACKAGE__->has_many(
  "contacts",
  "BotBuilder::Schema::Result::Contact",
  { "foreign.program_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program_messages

Type: has_many

Related object: L<BotBuilder::Schema::Result::ProgramMessage>

=cut

__PACKAGE__->has_many(
  "program_messages",
  "BotBuilder::Schema::Result::ProgramMessage",
  { "foreign.program_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-11-06 17:04:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2gjBbJkeK2J8PVuEDsuSwg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
