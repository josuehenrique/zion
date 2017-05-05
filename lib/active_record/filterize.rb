module ActiveRecord
  module Filterize
    extend ActiveSupport::Concern

    included do
      class_attribute :_filter_attributes
    end

    module ClassMethods
      def filterize
        scope :active_filter, lambda { |active=true| where(active: active).ordered }
      end

      def attr_filter(*attributes)
        self._filter_attributes = Set.new(attributes.map(&:to_s)) +
          (self._filter_attributes || [])
      end

      def filter_attributes
        self._filter_attributes
      end
    end
  end
end
