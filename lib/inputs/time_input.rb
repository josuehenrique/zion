module Inputs
  class TimeInput < SimpleForm::Inputs::Base
    def input
      addon_time { @builder.text_field(attribute_name, input_html_options) }
    end

    protected

    def input_html_classes
      super.unshift('string timepicker')
    end

    def input_html_options
      super.tap do |options|
        options[:size] ||= 8
        options[:data] ||= {}
      end
    end

    private

    def addon_time
      addon("<i class='fa fa-clock'></i>") { yield }
    end

    def addon(icon)
      "<div class='input-group timepicker'><span class='input-group-addon'>" + icon + "</i></span>" + yield + "</div>"
    end
  end
end
