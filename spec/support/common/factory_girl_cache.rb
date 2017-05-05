module FactoryGirl
  module Strategy
    class Cache
      def association(runner)
        runner.run(:cache)
      end

      def result(evaluation)
        repository.read(evaluation) || repository.store(evaluation)
      end

      def repository
        Repository.instance
      end
    end

    class Repository
      include Singleton

      def initialize
        recycle!
      end

      def recycle!
        self.repository = Hash.new { |hash, key| hash[key] = {} }
      end

      def read(evaluation)
        repository[evaluation.object.class][evaluation.object.attributes]
      end

      def store(evaluation)
        repository[evaluation.object.class][evaluation.object.attributes] = evaluation.object.tap do |object|
          evaluation.notify(:after_build, object)
          evaluation.notify(:before_create, object)
          evaluation.create(object)
          evaluation.notify(:after_create, object)
        end
      end

      protected

      attr_accessor :repository
    end
  end
end

FactoryGirl.register_strategy(:cache, FactoryGirl::Strategy::Cache)

RSpec.configure do |config|
  config.after do
    FactoryGirl::Strategy::Repository.instance.recycle!
  end
end
