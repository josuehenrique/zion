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
