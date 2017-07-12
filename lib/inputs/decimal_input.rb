module Inputs
  class DecimalInput < SimpleForm::Inputs::Base
    def input
      if input_html_classes.include?('money width-100') || input_html_classes.include?(:money)
        addon_money {@builder.text_field(attribute_name, input_html_options)}
      elsif input_html_classes.include?('percentage width-100') || input_html_classes.include?(:percentage)
        addon_percentage {@builder.text_field(attribute_name, input_html_options)}
      else
        @builder.text_field(attribute_name, input_html_options)
      end
    end

    protected

    def input_html_classes
      super.unshift('string')
    end

    def input_html_options
      super.tap do |options|
        options[:type] ||= :text
        options[:maxlength] ||= maxlength
        options[:data] ||= {}
        options[:data][:decimal] ||= true
        options[:data][:precision] ||= precision
      end
    end

    def maxlength
      return unless column_with_precision_and_scale?

      points, missing = (column.precision - column.scale).divmod(3)

      if missing.zero?
        column.precision + points
      else
        column.precision + points + 1
      end
    end

    def precision
      return unless column_with_precision_and_scale?

      column.scale
    end

    private

    def addon_money
      "<div class='input-group'><span class='input-group-addon'><b>R$</b></span>" + yield + "</div>"
    end

    def addon_percentage
      "<div class='input-group'><span class='input-group-addon'><b>%</b></span>" + yield + "</div>"
    end

    def column_with_precision_and_scale?
      column && column.precision && column.scale
    end
  end
end
