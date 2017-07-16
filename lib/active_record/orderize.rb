module ActiveRecord
  module Orderize
    extend ActiveSupport::Concern

    module ClassMethods
      def orderize(*attributes)
        attributes = [:name] if attributes.empty?

        scope :ordered, -> { order(*attributes) }
      end
    end
  end
end
