# == Schema Information
#
# Table name: inventories
#
#  id           :bigint(8)        not null, primary key
#  name         :string           not null
#  description  :text             not null
#  observations :text
#  active       :boolean          default(TRUE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Inventory < ActiveRecord::Base
  attr_accessible :name, :description, :observations

  attr_list :id, :name
  attr_search :name

  validates :name, :description, presence: true

  orderize
  filterize
end
