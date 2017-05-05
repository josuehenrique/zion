# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
user = User.new(
  name: 'Josué Henrique Ferreira da Silva',
  admin: true,
  email: 'josuehenriqueferreira@gmail.com',
  password: '150165',
  secret_phrase: 'biscoito'
)

user.save(validate: false)
