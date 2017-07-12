module Inputs
  class DateInput < SimpleForm::Inputs::Base
    def input
      addon_data { @builder.text_field(attribute_name, input_html_options) }
    end

    protected

    def input_html_classes
      super.unshift('string date-picker')
    end

    def input_html_options
      super.tap do |options|
        options[:size] ||= 10
        options[:data] ||= {}
        if mask
          options[:data][:mask] ||= mask
        end
      end
    end

    def mask
      options[:mask]
    end

    private

    def addon_data
      addon("<i class='fa fa-calendar'></i>") {yield}
    end

    def addon(icon)
      "<div class='input-group'><span class='input-group-addon'>" + icon + "</i></span>" + yield + "</div>"
    end
  end
end
