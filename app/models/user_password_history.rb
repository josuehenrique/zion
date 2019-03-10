# == Schema Information
#
# Table name: user_password_histories
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  encrypted_password :string
#  created_at         :datetime
#  updated_at         :datetime
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class UserPasswordHistory < ActiveRecord::Base
  attr_accessible :user_id, :encrypted_password

  belongs_to :user

  scope :by_encrypted_password, -> value { where(encrypted_password: value) }
end
