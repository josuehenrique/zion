class Shepherd < ActiveRecord::Base
  attr_accessible :name, :address_attributes, :church_id, :birth_dt
  attr_list :name
  attr_search :name

  has_one :address, as: :related, dependent: :destroy
  belongs_to :church

  accepts_nested_attributes_for :address, update_only: true

  validates :name, :church_id, :birth_dt, presence: true

  orderize
  filterize

  def to_s
    name
  end
end
