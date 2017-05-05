class Job < ActiveRecord::Base
  attr_accessible :name
  attr_list :name
  attr_search :name

  validates :name, presence: true

  orderize
  filterize

  def to_s
    name
  end
end
