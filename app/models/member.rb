# == Schema Information
#
# Table name: members
#
#  id                 :integer          not null, primary key
#  name               :string(150)      not null
#  father_name        :string(150)      not null
#  mother_name        :string(150)      not null
#  post_id            :integer
#  naturalness_id     :integer
#  job_id             :integer
#  convert_dt         :date             not null
#  birth_dt           :date             not null
#  gender             :string(1)        not null
#  educational_level  :string(2)        not null
#  marital_status     :string(2)        not null
#  active             :boolean          default(TRUE)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :bigint(8)
#  photo_updated_at   :datetime
#  email              :string
#
# Indexes
#
#  index_members_on_job_id          (job_id)
#  index_members_on_naturalness_id  (naturalness_id)
#  index_members_on_post_id         (post_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_id => jobs.id)
#  fk_rails_...  (naturalness_id => cities.id)
#  fk_rails_...  (post_id => posts.id)
#

class Member < ActiveRecord::Base
  attr_accessible :name, :father_name, :mother_name, :post_id, :naturalness_id, :job_id,
    :convert_dt, :birth_dt, :gender, :educational_level, :marital_status,
    :address_attributes, :email, :phone_attributes

  attr_list :name
  attr_search :name

  attr_accessor :naturalness_state_id, :naturalness_country_id

  has_enumeration_for :gender, with: Gender
  has_enumeration_for :educational_level, with: StudyLevel
  has_enumeration_for :marital_status, with: MaritalStatus

  belongs_to :job
  belongs_to :post
  belongs_to :naturalness, class_name: 'City'

  has_one :address, as: :related, dependent: :destroy

  has_one :phone, as: :related, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true

  accepts_nested_attributes_for :phone,
    allow_destroy: true, reject_if: lambda { |a| a[:number].blank? }

  has_attached_file :photo,
    url: "/anexos/:class/:attachment/:id/:style_:basename.:extension",
    path: ":rails_root/public/anexos/:class/:attachment/:id/:style_:basename.:extension"

  validates :name, :father_name, :mother_name, :post_id, :naturalness_id, :job_id,
    :convert_dt, :birth_dt, :gender, :educational_level, :marital_status, presence: true

  validates :name, uniqueness: true

  orderize :name
  filterize

  def to_s
    name
  end
end
