# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  admin                  :boolean          default(FALSE), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  login                  :string
#  administrator          :boolean          default(FALSE), not null
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :bigint(8)
#  avatar_updated_at      :datetime
#  secret_phrase          :string(30)       default("default"), not null
#  locked                 :boolean          default(TRUE)
#  active                 :boolean          default(TRUE), not null
#  name                   :string(150)      not null
#
# Indexes
#
#  index_users_on_active                (active)
#  index_users_on_admin                 (admin)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_login                 (login) UNIQUE
#  index_users_on_name                  (name)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :encrypted_password, :avatar,
                  :user_permits_attributes, :secret_phrase

  attr_protected :admin

  attr_search :name, :email

  attr_accessor :password_confirmation

  attr_list :name, :email

  has_many :user_password_histories

  has_many :user_permits
  has_many :permits, through: :user_permits
  has_many :roles, class_name: 'UserPermit'

  accepts_nested_attributes_for :user_permits, allow_destroy: true

  has_attached_file :avatar, styles: { medium: '65x65>', thumb: '30x30>' },
                    default_url: "/images/:rails_env/:class/:attachment/:filename"

  validates_attachment :avatar, size: { in: 1..5.megabytes },
                       content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png'] },
                       message: I18n.t('activerecord.errors.models.user.attributes.avatar.invalid_image_format')

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :secret_phrase, presence: true, if: :locked?

  before_save :verify_password_history, if: :encrypted_password_changed?
  before_save :downcase_and_remove_secret_phrase_accents, if: :secret_phrase_changed?
  after_save :save_changed_password_on_history, if: :encrypted_password_changed?

  orderize :name
  filterize

  def build_role(attributes)
    return if attributes.blank?
    roles.build(attributes)
  end

  def delete_role(role)
    return if role.blank?
    roles.delete(role)
  end

  def active_for_authentication?
    super && active?
  end

  def to_s
    name
  end

  def can_change?(user)
    !is_equal_me?(user) && can_change_me?(user)
  end

  def is_equal_me?(user)
    user == self
  end

  def can_change_me?(user)
    user.admin? || (!user.admin? && !self.admin?)
  end

  private

  def verify_password_history
    errors.add(:base, I18n.t('activerecord.errors.models.user.attributes.avatar.password_has_been_used_recently')) if password_belongs_to_history?
  end

  def password_belongs_to_history?
    user_password_histories.
      pluck(:encrypted_password).each do |encrypted_password|
      return true if Devise::Encryptor.compare(self.class, encrypted_password, password)
    end

    false
  end

  def save_changed_password_on_history
    UserPasswordHistory.create!(
      user_id: self.id,
      encrypted_password: changes['encrypted_password'].last
    )
  end

  def downcase_and_remove_secret_phrase_accents
    self.secret_phrase = secret_phrase.downcase.remover_acentos
  end
end
