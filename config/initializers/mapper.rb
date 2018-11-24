module ActionDispatch
  module Routing
    class Mapper
      module Resources
        class Resource
          attr_reader :controller, :path, :param, :options
        end

        def resources(*resources, &block)
          options = resources.extract_options!.dup

          if apply_common_behavior_for(:resources, resources, options, &block)
            return self
          end

          with_scope_level(:resources) do
            resource_scope(Resource.new(resources.pop, api_only?, options)) do
              yield if block_given?

              collection do
                get :index if parent_resource.actions.include?(:index)
                post :create if parent_resource.actions.include?(:create)
              end

              new do
                get :new
              end if parent_resource.actions.include?(:new)

              member do
                get :edit if parent_resource.actions.include?(:edit)
                get :show if parent_resource.actions.include?(:show)
                put :update if parent_resource.actions.include?(:update)
                delete :destroy if parent_resource.actions.include?(:destroy)

                get :activate if include_action?(:activate)
                get :inactivate if include_action?(:inactivate)
              end
            end
          end

          self
        end

        def include_action?(action)
          if parent_resource.options[:except].present?
            if parent_resource.options[:except].class.is_a?(Array)
              parent_resource.options[:except].exclude?(action)
            else
              parent_resource.options[:except] != action
            end
          elsif parent_resource.options[:only].present?
            if parent_resource.options[:only].is_a?(Array)
              parent_resource.options[:only].include?(action)
            else
              parent_resource.options[:only] != action
            end
          else
            true
          end
        end
      end
    end
  end
end
