# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1000.times do |i|
  active = [1,2,4,6,7].sample.even?
  notes = Faker::Lorem.sentence if active
  Customer.create!(
    custid: Faker::IDNumber.valid.split('-').last.to_i,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    dob: Faker::Date.birthday(18, 65),
    active: active,
    notes: notes
  )
end
