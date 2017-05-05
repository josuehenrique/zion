class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:reset_password]
  before_action :redirect_to_change_password, if: :needs_change_password?

  rescue_from CanCan::Unauthorized, with: lambda { render_error 403 }
  rescue_from Exceptions::UnauthorizedAction, with: lambda { render_error :unauthorized_action }
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found unless Rails.env.development?

  def render_error(status = 404, exception = nil)
    if request.xhr? && status == 403
      render js: "alert('Acesso negado!')"
    else
      respond_to do |format|
        format.html do
          render file: "#{Rails.root}/app/views/layouts/errors/#{status}", status: status
        end
        format.all { render nothing: true, status: status }
      end
    end
  end

  def redirect_to_change_password
    redirect_to unlock_administration_user_profile_path(current_user),
                alert: I18n.t('activerecord.errors.models.user.attributes.avatar.to_continue_change_your_password')
  end

  def needs_change_password?
    controller_path.exclude?('devise') &&
    current_user.locked && @_action_name != 'unlock' && @_action_name != 'update_unlock_attributes'
  end

  def authorize_resource!
    authorize_action!
    if action_should_be_authorized?(action_name, controller_name)
      authorize! action_name, controller_name
    end
  end

  private

  def open_modal(view = params[:action])
    render partial: 'crud/open_modal', locals: { view: view }
  end

  def authorize_action!
    method_name = "can_#{action_name.to_s}?"

    return unless params[:id]
    return unless resource.respond_to?(method_name)
    return unless resource.method(method_name).parameters.blank?

    raise Exceptions::UnauthorizedAction unless resource.send(method_name)
  end

  def action_should_be_authorized?(action_name, controller_name)
    Permit.by_controller(controller_name).by_action(action_name).any?
  end
end
