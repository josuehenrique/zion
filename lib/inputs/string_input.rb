module Inputs
  class StringInput < SimpleForm::Inputs::StringInput
    protected

    def input
      if input_html_classes.include?(:tel)
        addon_input('icon-phone') {super}
      elsif input_html_classes.include?(:password)
        addon_input('icon-key') {super}
      elsif input_html_classes.include?(:email)
        addon_input('icon-envelope-alt') {super}
      elsif input_html_classes.include?(:serial)
        addon_input('icon-key') {super}
      elsif input_html_classes.include?(:custom_prepend)
        addon_text {super}
      else
        super
      end
    end

    private

    def addon_input(klass)
      addon("<i class=" + klass + "></i>") {yield}
    end

    def addon(icon)
      "<div class='input-group'><span class='input-group-addon'>" + icon + "</i></span>" + yield + "</div>"
    end

    def addon_text
      "<div class='input-group'><span class='input-group-addon'><b>"+ input_html_options['prepend-text'] +"</b></span>" + yield + "</div>"
    end

    # SimpleForm do not use maxium length from validation
    def add_size!
      input_html_options[:size] ||= [maximum_length_from_validation, limit, SimpleForm.default_input_size].compact.min unless has_mask?
    end

    # SimpleForm do not add maxlength if html5 is disabled which not make any sense
    def add_maxlength!
      input_html_options[:maxlength] ||= maximum_length_from_validation || limit
    end
  end
end
