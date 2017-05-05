module ActiveRecord
  module ListAttributes
    extend ActiveSupport::Concern

    included do
      class_attribute :_list_attributes
    end

    module ClassMethods
      def attr_list(*attributes)
        self._list_attributes = Set.new(attributes.map { |a| a.to_s }) + (self._list_attributes || [])
      end

      def list_attributes
        self._list_attributes || accessible_attributes.to_set.select{|attr| !attr.blank?}
      end
    end
  end
end
