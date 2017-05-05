class Member < ActiveRecord::Base
  attr_accessible :name, :father_name, :mother_name, :post_id, :naturalness_id, :job_id,
                  :convert_dt, :birth_dt, :gender, :educational_level, :marital_status, :address_attributes
  attr_list :id, :name
  attr_search :name

  attr_accessor :state_id, :country_id

  has_enumeration_for :gender, with: Gender
  has_enumeration_for :educational_level, with: LevelOfStudy
  has_enumeration_for :marital_status, with: MaritalStatus

  belongs_to :job
  belongs_to :post
  belongs_to :naturalness, class_name: 'City'

  has_one :address, as: :related, dependent: :destroy

  accepts_nested_attributes_for :address, update_only: true

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
