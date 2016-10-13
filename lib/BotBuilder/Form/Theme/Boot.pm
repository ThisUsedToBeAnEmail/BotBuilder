package BotBuilder::Form::Theme::Boot;
use Moose::Role;

sub build_form_wrapper_class { ['form-horizontal'] }
sub build_do_form_wrapper {1}

sub build_form_tags {{
    wrapper_tag => 'div',
    after_start => '<div class="text-center">',
    before_end => '</div>'
}}

sub build_update_subfields {{
    all => {
        wrapper_tag => 'div',
        wrapper_class => 'form-group',
        label_class => 'col-lg-2 control-label',
        element_class => 'form-control',
        tags => {
            before_element => '<div class="col-lg-10">',
            after_element => '</div>'
        }
    },
    submit => {
        element_class => 'btn btn-primary',
        tags => {
            before_element => '<div>',
            after_element => '</div>'
        }
    }
}}

1;
