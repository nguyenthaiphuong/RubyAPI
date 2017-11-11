# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 20.times do |n|
#   Position.create!(name: FFaker::Name.name)
# end

# 20.times do |n|
#   Dept.create!(name: FFaker::Name.name)
# end
#Team.create(name: "nguyen thai phuong", manager_id: 1 )
User.create!(email: 'user@example.com', nickname: 'UOne', name: 'User One',
  password: "monkey67", position_id: 1, dept_id: 1, team_id: 1, phone: "12345678")