use utf8;
package BotBuilder::Schema::Result::Quote;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BotBuilder::Schema::Result::Quote

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

=head1 TABLE: C<quotes>

=cut

__PACKAGE__->table("quotes");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'quotes_id_seq'

=head2 troll_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 text

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "quotes_id_seq",
  },
  "troll_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "text",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 20:23:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ryMvugU8XwcbGjfG1E/SyQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
