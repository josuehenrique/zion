# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.
  config.wrappers :vertical_form_wrapper, class: 'form-group form-group-inline col-xs-12',
                  hint_class: :field_with_hint, error_class: :field_with_errors do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: 'col-xs-2'
    b.wrapper :div_input, tag: 'div', class: 'col-xs-6' do |ba|
      ba.use :input, class: 'col-xs-6'
      ba.use :hint,  wrap_with: { tag: :span, class: 'hint col-xs-12' }
      ba.use :error, wrap_with: { tag: :span, class: :error }
    end
  end

  config.wrappers :horizontal_form_wrapper, class: 'form-group col-md-8 col-sm-9 col-xs-10',
                  hint_class: :field_with_hint, error_class: :field_with_errors do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label
    b.wrapper :div_input, tag: 'div', class: 'controls' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :hint,  wrap_with: { tag: :span, class: 'hint col-xs-12' }
      ba.use :error, wrap_with: { tag: :span, class: :error }
    end
  end

  config.default_wrapper          = :vertical_form_wrapper
  config.boolean_style            = :inline
  config.button_class             = 'btn'
  config.error_notification_tag   = :div
  config.error_notification_class = 'error_notification'
  config.browser_validations = false
  config.input_class = 'form-control'
  config.label_class = 'control-label'
  # config.boolean_label_class = 'icheck-label'
end
