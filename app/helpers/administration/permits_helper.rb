module Administration::PermitsHelper
  def role_names(object, controller)
    object.permits.by_controller(controller).collect(&:name).sort.join(', ')
  end
end
