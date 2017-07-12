module Inputs
  class RadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
    def input
      label_method, value_method = detect_collection_methods
      input_html_options[:class] << :ace

      @builder.send("collection_#{input_type}",
                    attribute_name, collection, value_method, label_method,
                    input_options, input_html_options, &collection_block_for_nested_boolean_style
      )
    end

    protected

    def build_nested_boolean_style_item_tag(collection_builder)
      collection_builder.radio_button +  template.content_tag(:span, " #{collection_builder.text}", class: 'lbl')
    end
  end
end
