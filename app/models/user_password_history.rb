class UserPasswordHistory < ActiveRecord::Base
  attr_accessible :user_id, :encrypted_password

  belongs_to :user

  scope :by_encrypted_password, -> value { where(encrypted_password: value) }
end
