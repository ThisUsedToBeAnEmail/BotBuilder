package HTML::TableContent::Template::Javascript::Sort;

use Moo::Role;

around _add_sort => sub {
    my ($orig, $self, $args) = @_;

    my $element = $self->$orig($args);

    my $sort = HTML::TableContent::Element->new({ html_tag => 'i', text => '&#9658;' });
    $sort->onclick(sprintf "%sTc.sortData(this, %s, 'desc')", $self->table_name, $element->index);
    
    my $inner_html = $element->inner_html || [];
    if (scalar @{ $inner_html }) {
        $inner_html->[0] = $inner_html->[0] . $sort->render;
    } else {
        push @{ $inner_html }, '%s ' . $sort->render;
    }

    return $element->inner_html($inner_html);
};

no Moo::Role;

1;
