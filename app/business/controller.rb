class Controller
  def self.underscore(string)
    string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z\d])([A-Z])/, '\1_\2').
      tr('-', '_').
      downcase
  end

  def self.underscored(controller)
    Controller.underscore(controller.to_s.gsub('Controller', ''))
  end

  def self.extract_name(controller)
    Controller.underscored(controller).split('/')
  end

  def self.list
    removed = [
      ApplicationController,
      Devise::RegistrationsController,
      Devise::PasswordsController,
      Devise::SessionsController,
      CrudController,
      HomeController,
    ]

    arr = []

    # Load all controllers
    ctrl = Dir.new("#{Rails.root}/app/controllers").entries

    ctrl.each do |entry|
      if entry =~ /_controller/
        # check if the controller is valid
        arr << entry.camelize.gsub('.rb', '').constantize
      elsif entry =~ /^[a-z]*$/ # namescoped controllers
        Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |x|
          if x =~ /_controller/
            arr << "#{entry.titleize}::#{x.camelize.gsub('.rb', '')}".constantize
          end
        end
      end
    end

    arr - removed
  end

  def self.by_model(model_name)
    Controller.list.detect { |c| c.to_s.include?(model_name) }
  end

  def self.new_resource_path(model_name)
    controller = Controller.by_model(model_name)
    '/' + Controller.underscored(controller) + '/new'
  end
end
