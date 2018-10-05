class Congregated < ActiveRecord::Base
  attr_accessible :name, :email, :birth_dt, :entry_dt, :baptized,
    :phone_attributes, :address_attributes

  attr_list :name, :entry_dt, :baptized

  attr_search :name

  has_one :address, as: :related, dependent: :destroy
  has_one :phone, as: :related, dependent: :destroy

  accepts_nested_attributes_for :address, update_only: true
  accepts_nested_attributes_for :phone, update_only: true

  validates :name, :birth_dt, :entry_dt, presence: true

  orderize
  filterize

  def to_s
    name
  end
end
