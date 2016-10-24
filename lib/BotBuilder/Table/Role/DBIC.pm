package BotBuilder::Table::Role::DBIC;

use Moo::Role;

has rs => (
    is => 'ro',
    lazy => 1,
);

has result => (
    is => 'ro',
    lazy => 1,
);

sub _data {
    my $self = shift;

    if ( my $rs = $self->rs ) {
        $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');
        my @data = map { $_ } $rs->all;
        return \@data;
    } elsif ( my $result = $self->result ) {
        my %columns = $result->get_columns;
        my @data = \%columns;
        return \@data;
    } else {
    }
}

1;

