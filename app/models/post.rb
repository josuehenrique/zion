# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  name           :string(150)      not null
#  classification :string(1)        not null
#  active         :boolean          default(TRUE)
#  created_at     :datetime
#  updated_at     :datetime
#

class Post < ActiveRecord::Base
  attr_accessible :name, :classification
  attr_list :name
  attr_search :name

  has_enumeration_for :classification, with: PostType

  validates :name, :classification, presence: true

  orderize
  filterize

  def to_s
    name
  end
end
