# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
['registered', 'banned', 'moderator', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end
u = User.create_with(first_name: 'Martin', last_name: 'Schneider', password: 'changeme').find_or_create_by(email: 'mschneider85@gmx.de')
u.roles << Role.find_by(name: :admin) unless u.has_role? :admin
