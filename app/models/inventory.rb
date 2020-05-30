class Inventory < ActiveRecord::Base
  attr_accessible :name, :description, :observation

  attr_list :name
  attr_search :name

  validates :name, :description, presence: true

  orderize
  filterize
end
