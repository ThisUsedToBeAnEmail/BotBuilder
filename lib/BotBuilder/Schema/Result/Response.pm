use utf8;
package BotBuilder::Schema::Result::Response;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BotBuilder::Schema::Result::Response

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

=head1 TABLE: C<responses>

=cut

__PACKAGE__->table("responses");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'responses_id_seq'

=head2 text

  data_type: 'text'
  is_nullable: 1

=head2 feedback

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 contact_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 program_message_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 recieved

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
    sequence          => "responses_id_seq",
  },
  "text",
  { data_type => "text", is_nullable => 1 },
  "feedback",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "contact_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "program_message_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "recieved",
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

=head2 contact

Type: belongs_to

Related object: L<BotBuilder::Schema::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "contact",
  "BotBuilder::Schema::Result::Contact",
  { id => "contact_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 program_message

Type: belongs_to

Related object: L<BotBuilder::Schema::Result::ProgramMessage>

=cut

__PACKAGE__->belongs_to(
  "program_message",
  "BotBuilder::Schema::Result::ProgramMessage",
  { id => "program_message_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 20:23:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rp7WWde7XAq13UHL9aevUw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
