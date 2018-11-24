class Phone < ActiveRecord::Base
  attr_accessible :number, :phone_type, :related_id, :related_type, :whatsapp

  belongs_to :related, polymorphic: true

  has_enumeration_for :phone_type, with: PhoneType, reject_if: lambda { |a| a.number.blank? }

  validates :number, presence: true

  def to_s
    "#{PhoneType.t(phone_type)} - #{number}"
  end
end
