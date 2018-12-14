class Congregated < ActiveRecord::Base
  attr_accessible :name, :email, :birth_dt, :entry_dt, :baptized

  attr_list :name, :entry_dt, :baptized

  attr_search :name

  validates :name, :birth_dt, :entry_dt, presence: true

  orderize
  filterize

  def to_s
    name
  end
end
