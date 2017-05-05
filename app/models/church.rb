class Church < ActiveRecord::Base
  attr_accessible :name, :address_attributes
  attr_list :name
  attr_search :name

  has_one :address, as: :related, dependent: :destroy

  accepts_nested_attributes_for :address, update_only: true

  validates :name, presence: true

  orderize
  filterize

  def to_s
    name
  end
end
