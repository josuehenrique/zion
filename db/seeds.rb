# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

def create_members(
  email,
    post_id,
    city_id,
    job_id,
    naturalness_id,
    gender=Gender::MALE,
    education_level=StudyLevel::HIGH_SCHOOL,
    marital_status=MaritalStatus::UNMARRIED
)
  member =
    Member.new(
      name: Faker::Name.send("#{gender}_first_name"),
      father_name: Faker::Name.female_first_name,
      mother_name: Faker::Name.male_first_name,
      post_id: post_id,
      naturalness_id: naturalness_id,
      job_id: job_id,
      convert_dt: DateTime.current,
      birth_dt: DateTime.current - 30.years,
      gender: gender,
      educational_level: education_level,
      marital_status: marital_status,
      email: email,
    )

  member.save!

  member.address << Address.new(
    street: Faker::Address.street_name,
    city_id: city_id,
    number: rand(1000..2000),
    district: Faker::Address.community,
    zipcode: rand(11111111...99999999),
    complement: Faker::Address.secondary_address,
    reference_point: Faker::Lorem.paragraph,
    lat: Faker::Address.latitude,
    long: Faker::Address.longitude
  )

  member.phone << Phone.new(number: rand(62990000000...62999999999).to_s, phone_type: PhoneType::MOBILE, whatsapp: true)
end

user = User.new(
  name: 'Administrator',
  admin: true,
  email: 'zion@zion.com',
  password: '123456',
  secret_phrase: 'zion'
)

user.save(validate: false)
user.update_column(:admin, true)

# post = Post.create(name: 'Membro', classification: PostsType::ADMINISTRATION)
# country = Country.create('Brasil', 'BR')
# state = City.create(nfirst)
# city = City.create(nfirst)
# job  = Job.create(name: 'Marceneiro')

# 20.times.each do |i|
#   create_members("random#{i}@zion.com.br", post.id, city.id, job.id, city.id)
# end
