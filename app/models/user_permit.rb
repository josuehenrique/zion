class UserPermit < ActiveRecord::Base
  belongs_to :user
  belongs_to :permit

  delegate :controller_name, :controller, :modulus, :action, :name, to: :permit
end
