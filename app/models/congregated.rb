class Congregated < ActiveRecord::Base
  attr_accessible :name, :birth_dt, :entry_dt, :baptized
  attr_list :name
  attr_search :name

  validates :name, :birth_dt, :entry_dt, presence: true

  orderize
  filterize

  def to_s
    name
  end
end
