# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "Sausha-Rae Brown", email: "sausha@tamu.edu", password: "password")
User.create!(name: "Allison Kinnamore", email: "allison@tamu.edu", password: "password")
User.create!(name:  "Ben Jirka" , email: "ben@tamu.edu", password: "password")
User.create!(name:  "Eric Anderson", email: "eric@tamu.edu", password: "password")
User.create(name:  "Faheem Noorani", email: "faheem@tamu.edu", password: "password")
User.create(name:  "Jack Shirley", email: "jack@tamu.edu", password: "password")
User.create(name:  "Jenny Quinn", email: "jenny@tamu.edu", password: "password")
User.create(name:  "Justin Hong", email: "justinh@tamu.edu", password: "password")
User.create(name: "Justin Siu", email: "justins@tamu.edu", password: "password")
User.create(name:  "Luis De La Fuente", email: "luis@tamu.edu", password: "password")
User.create(name:  "Marc Riccione", email: "marc@tamu.edu", password: "password")
User.create(name:  "Paige Raun", email: "paige@tamu.edu", password: "password")
User.create(name:  "Rachel Jee", email: "rachel@tamu.edu", password: "password")
User.create(name:  "Reagan Jiang", email: "reagan@tamu.edu", password: "password")
User.create(name:  "Rebecca Carlson", email: "rebecca@tamu.edu", password: "password")
User.create(name:  "Sarika Subramanian", email: "sarika@tamu.edu", password: "password")
User.create(name:  "Steve", email: "steve@tamu.edu", password: "password")
User.create(name:  "Timothy Nguyen", email: "timothy@tamu.edu", password: "password")
User.create(name:  "Tony Shao", email: "tony@tamu.edu", password: "password")
User.create(name:  "Yara Mohamed", email: "yara@tamu.edu", password: "password")
User.create(name:  "Yuri Castro", email: "yuri@tamu.edu", password: "password")
User.create(name:  "Zheng Xiao", email: "zheng@tamu.edu", password: "password")
User.create(name:  "Philip Ritchey", email: "ritchey@tamu.edu", password: "password")

p "Created #{User.count} users"