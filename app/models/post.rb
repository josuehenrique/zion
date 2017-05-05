class Post < ActiveRecord::Base
  attr_accessible :name, :classification
  attr_list :name
  attr_search :name

  has_enumeration_for :classification, with: PostsType

  validates :name, :classification, presence: true

  orderize
  filterize

  def to_s
    name
  end
end
