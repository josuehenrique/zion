class Country < ActiveRecord::Base
  attr_accessible :name, :acronym
  attr_list :name, :acronym
  attr_search :name

  has_many :states

  validates :name, :acronym, presence: true

  orderize
  filterize
end
