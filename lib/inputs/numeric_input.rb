module Inputs
  class NumericInput < SimpleForm::Inputs::NumericInput
    private

    def input_html_options
      super.tap do |options|
        options[:data] ||= {}
        options[:data][:numeric] ||= true
      end
    end

    def add_size!
      input_html_options[:size] ||= nil unless has_mask?
    end
  end
end
