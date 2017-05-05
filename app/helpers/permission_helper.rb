module PermissionHelper
  def controller_has_action?(act, name = controller_name)
    Rails.application.routes.routes.map(&:defaults).
      select{ |a| a[:controller] && a[:controller].include?(name) }.
      map{ |a| a[:action].to_sym }.include? act
  end
end
