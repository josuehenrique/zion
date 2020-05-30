module ApplicationHelper
  include LinkHelper
  require "base/form_builder.rb"

  def real_attribute(attribute, klass = nil)
    if attribute.to_s.end_with?('_id')
      attribute = attribute.to_s.split('_id').first
      if klass.blank?
        return attribute
      else
        relation = klass.constantize.reflect_on_association(attribute.to_sym)
        return relation.class_name unless relation.blank?
      end
    end
    attribute
  end

  def simple_form_for(object, *args, &block)
    options = args.extract_options!
    options[:builder] ||= Base::FormBuilder

    super(object, *(args << options), &block)
  end

  def avatar_image(resource, options={})
    size = options.delete(:size)
    url = resource.avatar.blank? ? 'default_avatar.png' : resource.avatar.url(size)

    image_tag url, options
  end

  def box(title=nil, options={})
    additional_box_class = options.delete(:additional_box_class)

    content_tag(:section, nil, class: "box #{additional_box_class}") do
      header = body = ''
      header = build_header_box(title) if title

      body = build_body_box(header.blank?, options) { yield } if block_given?

      (header + body).html_safe
    end
  end

  def default_box(title, options={})
    box(title, options) do
      build_body_box(true, class_1_div: 'body-margin-top') { yield }
    end
  end

  def list_box(title, options={})
    additional_box_class = options.delete(:additional_box_class)

    content_tag(:section, nil, class: "box #{additional_box_class}") do
      header = body = ''
      header = build_header_box(title, {for_list: true}.merge(options))

      body =  build_body_box(true) do
        build_body_box(true, class_1_div: 'body-margin-top') { yield }
      end

      (header + body).html_safe
    end
  end

  def build_header_box(title, options={})
    for_list = options.delete(:for_list) { false }

    content_tag(:header, nil, class: 'panel_header') do
      h1_content = content_tag(:h1, title, class: 'title pull-left')
      badage = build_badage_filter(options) if for_list

      h1_content + badage
    end
  end

  def build_badage_filter(options={})
    url_params = options.delete(:url_params) { {} }

    if resource_class.respond_to?(:active_filter)
      content_tag(:div,
                  nil,
                  class: 'row pull-right',
                  style: 'margin-top: 25px;margin-right: 30px;') do
        content_tag(:small) do
          "#{link_to (t 'crud.default_states.active'), collection_path(url_params),
                     class: ('badge badge-md badge-primary' if params[:active].blank?)} |
            #{link_to (t 'crud.default_states.inactive'), collection_path({active: false}.merge(url_params)),
                      class: ('badge badge-md badge-primary' unless params[:active].blank?)}".html_safe
        end
      end
    end
  end

  def build_body_box(with_margin=true, options={})
    class_1_div = options.delete(:class_1_div)
    class_2_div = options.delete(:class_2_div)
    style = 'margin-top: 27px' if with_margin

    content_tag(:div, nil, class: "content-body #{class_1_div}") do
      content_tag(:div, nil, class: "row #{class_2_div}", style: style) do
        yield
      end
    end
  end

  def alert_box(messages, type)
    alert_type = alert_type_identifier(type)
    content_tag(:div, nil, class: "alert alert-#{alert_type.to_s} alert-dismissible fade in") do
      raw(close_button + extract_messages(type, messages))
    end
  end

  def close_button
    content_tag(
      :button,
      content_tag(:span, 'x', aria: { hidden: true }),
      class: 'close',
      type: :button,
      data: { dismiss: 'alert' },
      aria: { label: 'Close'}
    )
  end

  def alert_type_identifier(type)
    case type
      when 'alert' then 'warning'
      when 'notice' then 'success'
      else
        type
    end
  end

  def extract_messages(type, messages)
    if messages.is_a? Array
      content_tag(:ul) do
        html_messages = ''
        messages.map do |message|
          html_messages << content_tag(:li) do
            icon = content_tag(
              :i,
              nil,
              class: "fa fa-#{type == 'notice' ? 'check' : 'warning'}",
              style: 'margin-right: 5px'
            )

            icon + message
          end
        end

        html_messages.html_safe
      end
    else
      icon = content_tag(
        :i,
        nil,
        class: "fa fa-#{type == 'notice' ? 'check' : 'warning'}",
        style: 'margin-right: 5px'
      )
      icon + messages
    end
  end

  def submenu(controller, modulu, options = {})
    @name = options.delete(:name) || (t "controllers.#{controller}")

    @path = "#{modulu}_#{controller}_path"

    render 'layouts/main_menu/submenu', {controller: controller}
  end

  def menu_left_module(module_name, icon)
    sub_menus = nil
    menu_left = content_tag(:li, nil, class: "menu-#{module_name.to_s}") do
      content_tag(:a, nil, href: 'javascript:;') do
        content_tag(:i, nil, class: "fa fa-#{icon.to_s}") +
          content_tag(:span, I18n.t("menu.#{module_name.to_s}"), class: 'title') +
          content_tag(:span, nil, class: 'arrow').html_safe
      end +
      sub_menus = content_tag(:ul, nil, class: 'sub-menu') { yield }
    end

    menu_left.html_safe if sub_menus.include?('sub_')
  end
end
