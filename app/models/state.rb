class State < ActiveRecord::Base
  attr_accessible :name, :acronym
  attr_list :name, :acronym
  attr_search :name

  belongs_to :country
  has_many :cities

  validates :name, :acronym, presence: true

  orderize
  filterize

  scope :by_country, -> country_id { where(country_id: country_id) }

  def to_s
    "#{name} - #{acronym}"
  end
end
