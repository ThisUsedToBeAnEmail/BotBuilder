use utf8;
package BotBuilder::Schema::Result::ProgramMessage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BotBuilder::Schema::Result::ProgramMessage

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

=head1 TABLE: C<program_messages>

=cut

__PACKAGE__->table("program_messages");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'program_messages_id_seq'

=head2 message_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 program_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 step

  data_type: 'integer'
  is_nullable: 1

=head2 launch_type

  data_type: 'text'
  is_nullable: 1

=head2 launch_time

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "program_messages_id_seq",
  },
  "message_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "program_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "step",
  { data_type => "integer", is_nullable => 1 },
  "launch_type",
  { data_type => "text", is_nullable => 1 },
  "launch_time",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 message

Type: belongs_to

Related object: L<BotBuilder::Schema::Result::Message>

=cut

__PACKAGE__->belongs_to(
  "message",
  "BotBuilder::Schema::Result::Message",
  { id => "message_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
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

=head2 responses

Type: has_many

Related object: L<BotBuilder::Schema::Result::Response>

=cut

__PACKAGE__->has_many(
  "responses",
  "BotBuilder::Schema::Result::Response",
  { "foreign.program_message_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-11-06 17:04:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rf+S+JWKGGz6ghXSf7NO5g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
