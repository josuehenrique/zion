class RoleDefinition
  attr_accessor :object, :i18n, :controller

  def self.update(*attr)
    new(*attr).update
  end

  def initialize(object, controller = nil, i18n = I18n)
    self.object = object
    self.i18n = i18n
    self.controller = controller
  end

  def update
    missing_permits.each do |permit|
      object.build_role(permit: permit)
    end

    left_roles.each do |role|
      object.delete_role(role)
    end
  end

  protected

  def available_permits
    if controller
      Permit.by_controller(controller).ordered
    else
      Permit.ordered
    end
  end

  def current_permits
    if controller
      object.permits.by_controller(controller)
    else
      object.permits
    end
  end

  def missing_permits
    available_permits - current_permits
  end

  def left_roles
    permits = current_permits.reject { |permit| available_permits.include?(permit) }
    roles_from_permits(permits)
  end

  def roles_from_permits(permits)
    object.roles.where(permit_id: permits)
  end
end
