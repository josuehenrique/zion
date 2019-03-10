# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  name       :string(60)
#  acronym    :string(2)
#  country_id :integer          not null
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_states_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#

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
  scope :by_acronym, -> value { where("acronym ilike '#{value}%'") }

  def to_s
    "#{name} - #{acronym}"
  end
end
