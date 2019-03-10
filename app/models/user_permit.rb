# == Schema Information
#
# Table name: user_permits
#
#  id         :integer          not null, primary key
#  permit_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_user_permits_on_permit_id  (permit_id)
#  index_user_permits_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (permit_id => permits.id)
#  fk_rails_...  (user_id => users.id)
#

class UserPermit < ActiveRecord::Base
  belongs_to :user
  belongs_to :permit

  delegate :controller_name, :controller, :modulus, :action, :name, to: :permit
end
