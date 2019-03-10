# == Schema Information
#
# Table name: shepherds
#
#  id         :integer          not null, primary key
#  name       :string(150)      not null
#  church_id  :integer
#  birth_dt   :date             not null
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_shepherds_on_church_id  (church_id)
#

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
