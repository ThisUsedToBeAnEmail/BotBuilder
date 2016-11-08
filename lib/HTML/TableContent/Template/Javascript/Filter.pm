package HTML::TableContent::Template::Javascript::Filter;

use Moo::Role;

use HTML::TableContent::Element;

around _add_filter => sub {
    my ($orig, $self, $args) = @_;

    my $table = $self->$orig($args);
    my $filter_options = $self->filter_options;
    for ( keys %{ $filter_options } ) {
        my $header = $table->get_header($_);
        my $unique_values = $header->unique_cells;
        my $id = sprintf '%sFilter', $table->template_attr;

        my $label = HTML::TableContent::Element->new({
            html_tag => 'label',
            text => '&#x02261;', 
            onclick => sprintf "%sTc.toggleFilter('%s')", $self->table_name, $id
        });

        my $filter = HTML::TableContent::Element->new({ 
            html_tag => 'select',
            id => $id,
            class => 'form-control input-sg search-hide',
            autocomplete => 'off'
        });

        $filter->onchange(sprintf "%sTc.filter(this.value, %s)", $self->table_name, $header->index);
        $filter->add_child({ html_tag => 'option', value => 'all', text => 'All', selected => 'selected' });

        for ( keys %{ $unique_values } ) {
            $filter->add_child({ html_tag => 'option', value => $_, text => $_ });
        }

        my $inner_html = $header->inner_html;

        if (scalar @{ $inner_html }) {
            $inner_html->[0] = $inner_html->[0] . $label->render . $filter->render;
        } else {
            push @{$inner_html}, '%s ' . $label->render . $filter->render;
        }

        $header->inner_html($inner_html);
    }

    return $table;
};

no Moo::Role;

1;
