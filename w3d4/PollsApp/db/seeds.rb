# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: 'Apples')
User.create!(name: 'Charlie')
User.create!(name: 'Hermoine')

Poll.create!(title: 'Med History', author_id: 1)

Question.create!(prompt: 'Gas?', poll_id: 1)

Choice.create!(response_text: 'Yes', question_id: 1)
Choice.create!(response_text: 'No', question_id: 1)

Response.create!(user_id: 2, choice_id: 2)
Response.create!(user_id: 3, choice_id: 2)