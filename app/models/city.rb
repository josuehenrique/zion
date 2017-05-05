class City < ActiveRecord::Base
  attr_accessible :name
  attr_list :name
  attr_search :name

  belongs_to :state

  validates :name, presence: true

  orderize
  filterize

  scope :by_state, -> state_id { where(state_id: state_id) }

  def to_s
    "#{name} - #{state.acronym} - #{state.country.acronym}"
  end
end
