# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string(150)      not null
#  address_id :integer
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_churches_on_address_id  (address_id)
#

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
