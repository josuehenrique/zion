class Address < ActiveRecord::Base
  attr_accessible :street, :city_id, :number, :district, :zipcode, :lat, :long,
                  :complement, :reference_point
  attr_accessor :state

  belongs_to :city
  belongs_to :related, polymorphic: true

  validates :city_id, :street, :number, :district, :zipcode, presence: true
  validates :zipcode, numericality: true, length: { is: 8 }

  def to_s
    street
  end
end