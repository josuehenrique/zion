module Base
  class FormBuilder < SimpleForm::FormBuilder
    map_type :decimal, :float, to: Inputs::DecimalInput
    map_type :string, :tel, :password, :email, to: Inputs::StringInput
    map_type :integer, to: Inputs::NumericInput
    map_type :date, to: Inputs::DateInput
    map_type :time, to: Inputs::TimeInput
    map_type :radio_buttons, to: Inputs::RadioButtonsInput

    def sanitized_object_name
      @sanitized_object_name ||= object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
    end

    def back_button(value = nil, options = {})
      value, options = nil, value if value.is_a?(Hash)

      value ||= template.translate('crud.actions.back', cascade: true)
      options[:class] = "#{options[:class].join(" ")} btn btn-primary".strip
      options[:href] ||= template.smart_collection_path
      options[:id] ||= "#{object_name}_back"

      template.link_to "<i class='fa fa-arrow-left big'></i> ".html_safe + value,
                       options.delete(:href),
                       options
    end

    def button(type, *args, &block)
      options = args.extract_options!.dup
      options[:class] = [SimpleForm.button_class, options[:class]].compact
      disable = options.delete(:disable) { true }
      options['data-disable-with'] = 'Carregando...' if disable
      args << options
      if respond_to?("#{type}_button")
        send("#{type}_button", *args, &block)
      else
        send(type, *args, &block)
      end
    end

    def save_button(value = nil, options = {})
      value, options = nil, value if value.is_a?(Hash)
      value ||= template.translate('crud.actions.save', cascade: true)
      options[:class] = "#{options[:class].join(" ")} btn btn-primary".strip

      @template.button_tag("<i class='fa fa-check'></i> ".html_safe + value, options)
    end
  end
end
