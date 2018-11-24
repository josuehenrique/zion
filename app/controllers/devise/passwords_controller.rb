class Devise::PasswordsController < DeviseController
  prepend_before_action :require_no_authentication
  # Render the #edit only if coming from a reset password email link
  append_before_action :assert_reset_token_passed, only: :edit

  # GET /resource/password/new
  def new
    self.resource = resource_class.new
  end

  # POST /resource/password
  def create
    secret_phrase = resource_params[:secret_phrase]

    secret_phrase = secret_phrase .downcase.remover_acentos if secret_phrase

    user = User.where(email: resource_params[:email], secret_phrase: secret_phrase).first

    resource_params = self.resource_params.permit

    if user.blank?
      redirect_to new_user_password_path(resource_params),
                  alert: t('devise.passwords.please_fill_the_fiels')
    else
      user.password = random_password
      user.locked = true unless user.admin?

      if user.save
        redirect_to new_user_password_path(resource_params),
                    notice: t('devise.passwords.new_password_generated',
                              new_password: user.password)
      else
        redirect_to new_user_password_path(resource_params), alert: user.full_errors
      end
    end
  end

  def random_password
    (0...10).map { (65 + rand(26)).chr }.join.downcase
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_flashing_format?
      sign_in(resource_name, resource)
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      resource.errors.add(:base, :invalid_token) if resource.errors[:reset_password_token].present?
      respond_with resource
    end
  end

  protected

  def after_resetting_password_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    new_session_path(resource_name) if is_navigational_format?
  end

  # Check if a reset_password_token is provided in the request
  def assert_reset_token_passed
    if params[:reset_password_token].blank?
      set_flash_message(:alert, :no_token)
      redirect_to new_session_path(resource_name)
    end
  end

  # Check if proper Lockable module methods are present & unlock strategy
  # allows to unlock resource on password reset
  def unlockable?(resource)
    resource.respond_to?(:unlock_access!) &&
      resource.respond_to?(:unlock_strategy_enabled?) &&
      resource.unlock_strategy_enabled?(:email)
  end
end
