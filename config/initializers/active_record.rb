ActiveSupport.on_load(:active_record) do
  include ActiveRecord::ListAttributes
  include ActiveRecord::Orderize
  include ActiveRecord::SearchAttributes
  include ActiveRecord::Filterize

  extend EnumerateIt

  def self.filter_class
    (model_name.to_s.underscore + '_filter').camelize.constantize
  rescue
    DefaultFilter
  end

  def self.searcher_class
    (model_name.to_s.underscore + '_searcher').camelize.constantize
  rescue
    GenericSearcher
  end

  def to_s
    if respond_to?(:name)
      name
    else
      super
    end
  end

  def self.date_attribute?(attr)
    columns_hash[attr.to_s] && [:date, :datetime].include?(columns_hash[attr.to_s].type)
  end
end
