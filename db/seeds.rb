# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  {
    first_name: 'Pat',
    last_name: 'Rocchio',
    username: 'patrocc6',
    email: 'pat@test.com',
    password: 'password'
  }
)

user2 = User.create(
  {
    first_name: 'First Name',
    last_name: 'Last Name',
    username: 'newUser123',
    email: 'test@user.com',
    password: 'password'
  }
)

puts 'Created users'

categories = ["Technology", "Art", "Food"]
categories.each { |cat| Category.create(name: cat) }
puts 'Created categories'

project = Project.new(
  {
    name: 'Best Project Ever',
    description: 'This is the best project ever...',
    funding_goal: 10000,
    fund_by_date: Date.today,
    image: 'path_to_image',
  }
)
project.category = Category.first
project.creator = user
project.save
puts 'Created project'

pledge = Pledge.new(
  {
    user: user2,
    project: project,
    amount: 1000
  }
)
pledge.save
puts 'Created pledge'
