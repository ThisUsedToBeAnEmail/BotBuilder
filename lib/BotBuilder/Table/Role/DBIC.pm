package BotBuilder::Table::Role::DBIC;

use Moo::Role;

has rs => (
    is => 'ro',
    lazy => 1,
);

sub _data {
    my $self = shift;

    my $rs = $self->rs;
    $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');
    my @data = map { $_ } $rs->next;
    return \@data;
}

1;
