# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string(60)
#  acronym    :string(2)
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#

class Country < ActiveRecord::Base
  attr_accessible :name, :acronym

  attr_list :name, :acronym
  attr_search :name

  has_many :states

  validates :name, :acronym, presence: true

  orderize
  filterize
end
