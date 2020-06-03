module CrudHelper
  include FilterHelper
  include PermissionHelper

  def singular(klass = resource_class)
    klass.model_name.human
  end

  def plural(klass = resource_class)
    klass.model_name.human(count: 'many')
  end

  def paginate(records = collection, options = {})
    will_paginate records, options if records.respond_to?(:total_pages)
  end

  def remote_paginate(records = collection)
    if records.respond_to?(:total_pages)
      will_paginate records, renderer: RemotePaginator::LinkRenderer
    end
  end

  # Get modal attributes and intersect with +params[:attributes]+ if exists
  def attributes
    attributes = resource_class.list_attributes
    attributes &= params[:attributes].split(',') if params[:attributes]

    associations = resource_class.reflect_on_all_associations

    attributes.map do |attribute|
      next if attribute.blank?
      association = associations.detect { |association| association.foreign_key == attribute }

      # If attribute is an association and is not polymorphic, use the association
      # name instead of the foreign key.
      if association
        association.name unless association.options.include? :polymorphic
      else
        attribute
      end
    end.compact
  end

  def form_action_link(params = {})
    resource.persisted? ? resource_path(params) : collection_path(params)
  end

  def table_list
    yield
  end

  def create?
    can?(:new, controller_name) && controller_has_action?(:new) && controller_has_action?(:create)
  end

  def create_link(search = nil, params = {}, options = {})
    path = options.delete(:path) { new_resource_path({ search: search.permit! }.merge(params)) }

    link_to raw("<i class='fa fa-plus'></i> " + t('crud.actions.new')),path,
            options.merge({class: 'btn btn-primary'})
  end

  def localized_attribute(klass, attribute_name)
    klass.human_attribute_name real_attribute(attribute_name)
  end

  def formatted_attribute(resource, attribute, options = {})
    attribute = real_attribute(attribute)

    human_attr = attribute.to_s + '_humanize'
    if resource.respond_to?(human_attr)
      return resource.send(human_attr)
    else
      value = resource.send(attribute)
      value = value.send(options[:attribute_method]) if options[:attribute_method]

      case value.class.to_s
        when 'Date', 'Time', 'ActiveSupport::TimeWithZone'
          I18n.l(value)
        when 'BigDecimal'
          number_to_currency(value, unit: '')
        when 'Fixnum'
          value.to_s
        else
          value
      end
    end
  end

  def value_by_field_type(value)
    klass = value.class
    # TODO: Verificar pq nao funciona usando case
    if klass == TrueClass
      "<i class='fa fa-check-circle-o green'></i>".html_safe
    elsif klass == FalseClass
      "<i class='fa fa-times-circle red'></i>".html_safe
    elsif CPF.valid?(value)
      CPF.new(value).formatted
    elsif CNPJ.valid?(value)
      CNPJ.new(value).formatted
    else
      value.blank? ? '-' : value
    end
  end

  def show_link(object)
    if controller_has_action?(:show, object_controller_name(object))
      link_to raw("<i class='glyphicon glyphicon-eye-open glyphicon-table blue'></i>"),
              resource_path(object, search: params[:search], page: params[:page]),
              data: { placement: :top, rel: :tooltip },
              class: 'blue', title: (I18n.t 'crud.actions.show') if can? :show, object
    end
  end

  def extract_params
    params.dup.to_h.except('page', 'action', 'controller', 'search', 'utf8')
  end

  def object_controller_name(object)
    object.class.name.underscore.pluralize
  end

  def link_edit(object, options = {})
    if controller_has_action?(:edit, object_controller_name(object))
      path = options[:path]
      path ||= edit_resource_path(object, search: params[:search], page: params[:page])

      data = { placement: :top, rel: :tooltip }
      data.merge!({ remote: true }) if options[:remote]

      link_to raw("<i class='glyphicon glyphicon-edit glyphicon-table orange'></i>"),
              path, data: data, class: 'blue', title: I18n.t('crud.actions.edit') if can? :edit, object
    end
  end

  def destroy_link(object, options={})
    return unless controller_has_action? :destroy

    path = options.delete(:path) || resource_path(object)

    if can? :deletar, object
      link_to(
        raw("<i class='glyphicon glyphicon-trash red glyphicon-table'></i>"),
        path,
        method: :delete,
        data: {
          placement: :top,
          rel: :tooltip,
          confirm: (I18n.t 'messages.are_you_sure')
        },
        class: 'red tooltip-error',
        title: (I18n.t 'crud.actions.delete')
      )
    end
  end

  def icons
    content_tag :div, class: 'clearfix action-buttons' do
      yield
    end
  end

  def situation_change_link(object)
    return destroy_link(object) unless object.respond_to?(:active)

    active = object.active if object.respond_to?(:active)

    data = {
      placement: :top,
      rel: :tooltip,
      confirm: (I18n.t 'messages.are_you_sure')
    }

    if active
      link_to(
        raw("<i class='glyphicon glyphicon-ban-circle glyphicon-table red'></i>"),
        inactivate_resource_path(object),
        data: data,
        class: :red,
        title: (I18n.t 'crud.actions.inactivate')
      ) if can? :inactivate, object
    else
      link_to(
        raw("<i class='glyphicon glyphicon-ok green glyphicon-table'></i>"),
        activate_resource_path(object),
        data: data,
        class: :orange,
        title: (I18n.t 'crud.actions.activate')
      ) if can? :activate, object
    end
  end

  def activate_resource_path(object)
    edit_resource_path(object).gsub('edit', 'activate')
  end

  def inactivate_resource_path(object)
    edit_resource_path(object).gsub('edit', 'inactivate')
  end

  def icon_1
    'width=10px'
  end

  def icon_2
    'width=65px'
  end

  def icon_3
    'width=90px'
  end

  def icon_4
    'width=110px'
  end

  def resource_name
    resource.class.to_s.downcase
  end

  def link_back(options={})
    with_border = options.delete(:with_border)
    border = "btn-border" if with_border
    options[:class]     = "btn btn-primary #{border}"
    options[:href]  ||= smart_collection_path
    options[:id]    ||= "#{resource_name}_back"

    link_to "<i class='fa fa-arrow-left'></i> ".html_safe + t('crud.actions.back'),
            options.delete(:href),
            options
  end

  def link_form_edit(options={})
    with_border = options.delete(:with_border)
    border = "btn-border" if with_border
    options[:class]     = "btn btn-primary #{border}"
    options[:href]    ||=  edit_resource_path(search: params[:search], page: params[:page])
    options[:id]      ||= "#{resource_name}_edit"
    icon_color_class    = options.delete(:icon_color)

    link_to "<i class='fa fa-edit #{icon_color_class}'></i> ".html_safe + t('crud.actions.edit'),
            options.delete(:href),
            options if can? :edit, resource
  end

  def form_buttons
    content_tag(:div, nil, class: 'col-xs-12 form-buttons') do
      content_tag(:br, nil) do
        yield
      end
    end
  end

  def list_group
    content_tag(:div, nil, class: 'list-group') do
      yield
    end
  end

  def show_row(attribute, options = {})
    current_resource =  options.delete(:resource) || resource
    value = formatted_attribute(current_resource, attribute, options)
    value = value_by_field_type(value).to_s

    show_attr(localized_attribute(current_resource.class, attribute), value, options)
  end

  def show_attr(name, value, options = {})
    value = options[:prefix] + value if options[:prefix]

    str_value = "<b>#{name}: </b>#{value}".html_safe

    list_group_item(str_value)
  end

  def list_group_item(item_value)
    content_tag :div, item_value, class: 'list-group-item '
  end

  def explain(resource_name, explain_action, options={})
    heading = options.delete(:heading){ :h1 }
    heading_color = options.delete(:heading_color){ '#505458' }
    explanation_color = options.delete(:explanation_color){ '#505458' }

    content_tag(:div, nil, class: 'position-relative inline') do
      content_tag(heading, nil, style: "color: #{heading_color}") do
        icon = content_tag(:i, nil, class: 'fa fa-angle-double-right')
        explanation = content_tag(:small, explain_action,
                             class: 'btn-lg padding-0',
                             style: "color: #{explanation_color}")
        raw(resource_name + ' ' + icon + ' ' + explanation)
      end
    end
  end

  def modal_header
    content_tag(:div, nil, class: 'modal-header') do
      content_tag(:button, 'x',
                  style:"color: white",
                  class: 'close',
                  data: {dismiss: 'modal'},
                  aria: { hidden: true }) +
        yield
    end
  end

  def default_modal_header(title, explanation, options={})
    heading_color = options.delete(:heading_color){ '#fff' }
    explanation_color = options.delete(:explanation_color){ '#dadada' }

    options.merge!(
      heading_color: heading_color,
      explanation_color: explanation_color,
      heading: :h2
    )

    modal_header do
      explain(title, explanation, options)
    end
  end

  def can_edit?(object)
    object.class.respond_to?(:active_filter) && object.active
  end
end
