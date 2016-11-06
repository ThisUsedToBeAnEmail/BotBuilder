use utf8;
package BotBuilder::Schema::Result::SlackBot;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BotBuilder::Schema::Result::SlackBot

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

=head1 TABLE: C<slack_bots>

=cut

__PACKAGE__->table("slack_bots");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'slack_bots_id_seq'

=head2 slack_hook

  data_type: 'text'
  is_nullable: 1

=head2 slack_channel

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "slack_bots_id_seq",
  },
  "slack_hook",
  { data_type => "text", is_nullable => 1 },
  "slack_channel",
  { data_type => "text", is_nullable => 1 },
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
  { "foreign.slack_bot_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-11-06 17:04:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DmjQQoT2IoGwf5leVG8iNw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
