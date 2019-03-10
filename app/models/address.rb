# == Schema Information
#
# Table name: addresses
#
#  id              :integer          not null, primary key
#  city_id         :integer          not null
#  related_id      :integer          not null
#  related_type    :string           not null
#  street          :string           not null
#  complement      :string
#  number          :integer          default(0), not null
#  district        :string           not null
#  zipcode         :string(8)        not null
#  lat             :decimal(14, 6)
#  long            :decimal(14, 6)
#  reference_point :string           not null
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_addresses_on_city_id                      (city_id)
#  index_addresses_on_related_id_and_related_type  (related_id,related_type)
#  index_addresses_on_related_type_and_related_id  (related_type,related_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#

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
