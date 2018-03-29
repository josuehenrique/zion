module Base
  class FormBuilder < SimpleForm::FormBuilder
    map_type :decimal, :float, to: Inputs::DecimalInput
    map_type :string, :tel, :password, :email, to: Inputs::StringInput
    map_type :integer, to: Inputs::NumericInput
    map_type :date, to: Inputs::DateInput
    map_type :time, to: Inputs::TimeInput
    map_type :boolean, to: Inputs::BooleanInput
    map_type :radio_buttons, to: Inputs::RadioButtonsInput

    def sanitized_object_name
      @sanitized_object_name ||= object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
    end


    def input(attribute_name, options = {}, &block)
      if reflection = find_association_reflection(attribute_name)
        if reflection.macro == :belongs_to
          if options[:label]
            attribute_name = reflection.options[:foreign_key] || "#{reflection.name}_id"
          else
            attribute_name = reflection.options[:foreign_key] || (options[:as] == :auto_complete ? reflection.name : :"#{reflection.name}_id")
          end
        end

        if options[:input_html] && options[:input_html][:class]
          options[:input_html][:class] = "#{options[:input_html][:class]} width-100"
        else
          options[:input_html] ||= { class: 'width-100'}
        end

        klass_name = reflection.class_name

        if options[:shortcut_register]
          route = "/#{klass_name.underscore.pluralize}/new"
          options[:input_html].merge!({link_to_new: route})
        end

        options.reverse_merge!(as: :select, collection: options[:collection] || klass_name.to_s.camelize.constantize.ordered)
      elsif collection = find_enumeration_reflection(attribute_name)
        options.reverse_merge!(as: :select, collection: collection)
      end

      super
    end

    def find_enumeration_reflection(attribute_name)
      object.class.enumerations[attribute_name.to_sym] if object.class.respond_to?(:enumerations)
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
