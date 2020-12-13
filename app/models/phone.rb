# == Schema Information
#
# Table name: phones
#
#  id               :integer          not null, primary key
#  number           :string           not null
#  related_type     :string           not null
#  related_id       :integer          not null
#  phone_carrier_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#  phone_type       :string(11)       default("residential"), not null
#  whatsapp         :boolean          default(TRUE), not null
#
# Indexes
#
#  index_phones_on_related_type_and_related_id  (related_type,related_id)
#
# Foreign Keys
#
#  fk_rails_...  (phone_carrier_id => phone_carriers.id)
#

class Phone < ActiveRecord::Base
  attr_accessible :number, :phone_type, :related_id, :related_type, :whatsapp

  belongs_to :related, polymorphic: true

  has_enumeration_for :phone_type, with: PhoneType

  validates :number, presence: true

  def to_s
    "#{PhoneType.t(phone_type)} - #{number}"
  end
end
