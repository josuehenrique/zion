namespace :permit do
  desc "Loading all models and their related controller methods inpermissions table."
  task(create: :environment) do
    include PermissionHelper

    Controller.list.each do |controller|
      #only that controller which represents a model
      name = Controller.extract_name(controller)
      # Module
      m_name = name[0]
      # Controller
      c_name = name[1]

      puts "#{m_name}: #{c_name}" unless Rails.env.test?

      next if allowed_controller?(m_name, c_name)

      list_actions(controller).each do |method|
        if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+)$/ #add_user, add_user_info, Add_user, add_User
          name, cancan_action = eval_cancan_action(m_name, c_name, method)
          if controller_has_action?(cancan_action.to_sym, m_name + '/' + c_name)
            write_permission(m_name, c_name, cancan_action, name)
          end
        end
      end
    end
  end
end

# this method returns the cancan action for the action passed.
def eval_cancan_action(module_name, controller, action)
  crud_controller_actions = %w( index edit show activate new destroy inactivate )

  if crud_controller_actions.include?(action)
    name = I18n.t("actions.crud_controller.#{action}")
  else
    name = I18n.t("actions.#{module_name}.#{controller}.#{action}")
  end

  if name.include?('translation missing')
    raise "Ação sem tradução: #{module_name}.#{controller}.#{action}"
  end

  return name, action.to_s
end

# Check if the permission is present else add a new one.
def write_permission(modulus, controller, cancan_action, name)
  permission = Permit.where(
    modulus: modulus,
    controller: controller,
    action: cancan_action
  ).first

  unless permission
    if I18n.t("controllers.#{controller}").include?('translation missing')
      raise "Controller sem tradução: #{controller}"
    end

    permission = Permit.new
    permission.name = name
    permission.modulus = modulus
    permission.controller = controller
    permission.action = cancan_action
    permission.save!
  end
end

def list_actions(controller)
  removed = %w( modal create update )
  controller.action_methods - ApplicationController.action_methods - removed
end

def allowed_controller?(modulus, controller)
  ['administration/user_profiles'].include?(modulus + '/' + controller)
end
