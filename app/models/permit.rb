# == Schema Information
#
# Table name: permits
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  modulus    :string           not null
#  controller :string           not null
#  action     :string           not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_permits_on_action      (action)
#  index_permits_on_controller  (controller)
#  index_permits_on_modulus     (modulus)
#  index_permits_on_name        (name)
#

class Permit < ActiveRecord::Base
  attr_accessible :action, :name, :controller

  has_many :user_permits, dependent: :destroy

  validates :name, :action, :controller, :modulus, presence: true
  validates :action, uniqueness: { scope: [:modulus, :controller] }

  orderize

  scope :by_module, -> value { where(module: value) }
  scope :by_controller, -> controller { where(controller: controller) }
  scope :by_action, -> action { where(action: action) }

  def controller_name
    I18n.translate("controllers.#{controller}")
  end
end
