class Administration::UserProfilesController < CrudController
  defaults resource_class: User, collection_name: :users

  def update
    update! { root_path }
  end

  def unlock
    resource.locked? ? render(:unlock) : redirect_to(root_path)
  end

  def update_unlock_attributes
    resource.assign_attributes(params[:user])

    if resource.save
      resource.update_column(:locked, false)
      sign_in(resource, bypass: true)
      redirect_to root_path, notice: I18n.t('devise.registrations.updated')
    else
      redirect_to unlock_administration_user_profile_path(current_user),
                  alert: resource.errors.full_messages
    end
  end

  protected

  def update_resource(object, attributes)
    object.assign_attributes(*attributes)

    resource.reload.update_without_password(attributes[0]) unless object.encrypted_password_changed?

    sign_in(object, bypass: true) if object.save && (current_user == object)
  end
end
