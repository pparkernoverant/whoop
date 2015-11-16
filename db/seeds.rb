# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'test_user_1@test.com', username: 'test_user_1', password: 'test')
User.create(email: 'test_user_2@test.com', username: 'test_user_2', password: 'test')

Business.create(name: 'test_business_1')
Business.create(name: 'test_business_2')

Review.create(user: User.find_by(username: 'test_user_1'), business: Business.find_by(name: 'test_business_1'), content: 'test review 1', rating: '4')
Review.create(user: User.find_by(username: 'test_user_1'), business: Business.find_by(name: 'test_business_2'), content: 'test review 2', rating: '3')
Review.create(user: User.find_by(username: 'test_user_2'), business: Business.find_by(name: 'test_business_2'), content: 'test review 3', rating: '5')
