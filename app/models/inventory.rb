class Inventory < ActiveRecord::Base
  attr_accessible :name, :description, :observation

  attr_list :id, :name
  attr_search :name

  validates :name, :description, presence: true

  orderize
  filterize
end
