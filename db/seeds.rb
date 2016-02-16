# Create Roles
['registered', 'banned', 'moderator', 'admin', 'superadmin'].each do |role|
  Role.find_or_create_by({name: role})
end
# Create Superadmin
u = User.create_with(first_name: 'Martin', last_name: 'Schneider', password: 'changeme').find_or_create_by(email: 'mschneider85@gmx.de')
u.roles << Role.find_by(name: :superadmin) unless u.has_role? :superadmin
