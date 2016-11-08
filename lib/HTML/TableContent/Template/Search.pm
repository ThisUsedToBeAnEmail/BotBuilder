package HTML::TableContent::Template::Search;

use Moo::Role;
use HTML::TableContent::Element;

has search_columns => (
    is => 'rw',
    lazy => 1,
    default => sub { { } },
);

sub searchable { return defined $_[0]->search_columns; }

around _set_html => sub {
    my ($orig, $self, $args) = @_;

    my $element = $self->$orig($args);

    if ($element->attributes->{search}) {
        $self->search_columns->{$element->index} = $element->text;
    }

    return $element;
};

around last_chance => sub {
    my ($orig, $self, $args) = @_;

    my $table = $self->$orig($args);

    if ($self->searchable) {
        $table = $self->add_search_box($table);
    }
    
    return $table;
};

sub add_search_box {
    return $_[1];
}

no Moo::Role;

1;
