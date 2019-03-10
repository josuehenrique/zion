# == Schema Information
#
# Table name: jobs
#
#  id         :integer          not null, primary key
#  name       :string(150)      not null
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#

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
