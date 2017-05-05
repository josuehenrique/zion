class Administration::UsersController < CrudController
  before_action :redirect_if_cannot_change, only: [:update, :edit]

  def inactivate
    (resource == current_user) ? redirect_to(administration_users_path) : super
  end

  def activate
    (resource == current_user) ? redirect_to(administration_users_path) : super
  end

  protected

  def update_resource(object, attributes)
    object.assign_attributes(*attributes)

    resource.reload.update_without_password(attributes[0]) unless object.encrypted_password_changed?

    sign_in(object, bypass: true) if object.save && (current_user == object)
  end

  def redirect_if_cannot_change
    redirect_to collection_path unless resource.can_change_me?(current_user)
  end
end
