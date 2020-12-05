# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create(first_name: 'Zach', last_name: 'Stearns', email: 'zach@email.com', password: 'password')
user2 = User.create(email: 'test@gmail.com', password: 'test', first_name: 'Alex', last_name: 'Rivero')


user4 = User.create(first_name: 'Zach', last_name: 'Stearns', email: 'zach12@email.com', password: 'password')

friends = Friendship.create!(user_id: 4, friend_id: 3)
