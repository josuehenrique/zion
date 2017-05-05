module LinkHelper
  def actions_group
    content_tag :div, class: 'well well-sm' do
      yield
    end
  end

  def actions_member(options = {})
    name = options.delete(:name)
    name ||= t 'messages.allowed_actions'

    (content_tag :div, class: 'btn-group' do
      name = "<button data-toggle='dropdown'
               class='btn btn-sm btn-primary dropdown-toggle'> #{name}
               <span class='icon-caret-down icon-on-right'></span>
              </button>"

      menu = (content_tag :ul, class: 'dropdown-menu dropdown-default ui-menu', id: 'menu' do
        yield
      end)

      (name + menu).html_safe
    end)
  end

  def actions(options = {})
    actions_group do
      actions_member(options) { yield }
    end
  end

  def action_group_link(link)
    ul = (content_tag :ul do
      yield
    end)

    action_link(link_to(link, '#') + ul).html_safe
  end

  def action_link(link)
    content_tag :li, class: 'ui-menu-item' do
      link
    end
  end

  def exist_route?(route, environment = {})
    Rails.application.routes.recognize_path(route, environment)
    true
  rescue ActionController::RoutingError
    false
  end

  def create?
    can?(:create, controller_name) && exist_route?(new_resource_path)
  rescue NoMethodError
    false
  end

  def create_link(options = {})
    str = t('buttons.new', resource: singular, cascade: true)
    path = options.delete(:path) || new_resource_path(search: params[:search])
    opts = options.delete(:opts) || {}

    if create?
      link_to(
        raw("<i class='icon-plus'></i> " + str),
        path,
        opts.merge(class: 'btn btn-sm btn-primary')
      )
    end
  end

  def show_link(object, options = {})
    data = { placement: :top, rel: :tooltip }
    data.merge!(
      remote: true,
      toggle: :modal,
      target: 'modal-window'
    ) if options.delete(:modal)

    if can? :read, object
      link_to(
        raw("<i class='icon-eye-open bigger-130'></i>"),
        options.delete(:path) || resource_path(object),
        options.merge(class: :blue, data: data, title: (I18n.t 'actions.show'))
      )
    end
  end

  def edit_link(object, options = {})
    if can? :update, object
      link_to(
        raw("<i class='icon-cog bigger-130'></i>"),
        options.delete(:path) || edit_resource_path(object),
        data: { placement: :top, rel: :tooltip },
        class: :green, title: (I18n.t 'actions.edit')
      )
    end
  end

  def destroy_link(object, options = {})
    path = options.delete(:path) || resource_path(object)

    if (can? :manage, object) && exist_route?(path, method: :delete)
      link_to(
        raw("<i class='icon-trash bigger-130'></i>"),
        path,
        method: :delete,
        data: {
          placement: :top,
          rel: :tooltip,
          confirm: (I18n.t '.are_you_sure')
        },
        class: 'red tooltip-error',
        title: (I18n.t 'actions.delete')
      )
    end
  end

  def situation_change_link(object)
    return destroy_link(object) unless object.respond_to?(:active)

    active = object.active if object.respond_to?(:active)

    data = {
      placement: :top,
      rel: :tooltip,
      confirm: (I18n.t '.are_you_sure')
    }

    if active
      link_to(
        raw("<i class='icon-minus bigger-130'></i>"),
        inactivate_resource_path(object),
        data: data,
        class: :red,
        title: (I18n.t 'actions.inactivate')
      ) if can? :inactivate, object
    else
      link_to(
        raw("<i class='icon-ok bigger-130'></i>"),
        activate_resource_path(object),
        data: data,
        class: :orange,
        title: (I18n.t 'actions.activate')
      ) if can? :activate, object
    end
  end

  def activate_resource_path(object)
    edit_resource_path(object).gsub('edit', 'activate')
  end

  def inactivate_resource_path(object)
    edit_resource_path(object).gsub('edit', 'inactivate')
  end

  def icons
    content_tag :div, class: 'visible-md visible-lg hidden-sm hidden-xs action-buttons' do
      yield
    end
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
end
