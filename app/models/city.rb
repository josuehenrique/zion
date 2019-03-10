# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string(150)      not null
#  state_id   :integer          not null
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_cities_on_state_id  (state_id)
#
# Foreign Keys
#
#  fk_rails_...  (state_id => states.id)
#

class City < ActiveRecord::Base
  attr_accessible :name
  attr_list :name
  attr_search :name

  belongs_to :state

  validates :name, presence: true

  orderize
  filterize

  scope :by_state, -> state_id { where(state_id: state_id) }
  scope :by_name, -> value { where("name ilike '#{value}%'") }

  def to_s
    "#{name} - #{state.acronym} - #{state.country.acronym}"
  end
end
