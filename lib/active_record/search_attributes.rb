module ActiveRecord
  module SearchAttributes
    extend ActiveSupport::Concern

    included do
      class_attribute :_search_attributes
      class_attribute :_force_search
    end

    module ClassMethods
      def attr_search(*attributes)
        self._search_attributes = Set.new(attributes.map { |a| a.to_s }) + (self._search_attributes || [])
      end

      def search_attributes
        self._search_attributes
      end

      def force_search(opt)
        self._force_search = opt
      end

      def force_search?
        return false if Rails.env.test?

        self._force_search || false
      end
    end
  end
end
