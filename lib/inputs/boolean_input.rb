module Inputs
  class BooleanInput < SimpleForm::Inputs::BooleanInput
    def input
      build_check_box
    end

    private

    def label_input
      if options[:label] == false
        input
      elsif nested_boolean_style?
        html_options = label_html_options.dup
        html_options[:class] ||= []
        html_options[:class].push(:checkbox)

        build_hidden_field_for_checkbox +
          @builder.label(label_target, html_options) {
            build_check_box_without_hidden_field + label_text
          }
      else
        input + label
      end
    end

    def build_check_box(unchecked_value = true)
      input_html_options[:style] = 'width: 34px'
      @builder.check_box(attribute_name, input_html_options, checked_value, unchecked_value)
    end
  end
end
