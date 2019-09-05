puts 'starting seed'
puts '*********************'
puts 'Destroy users..'
User.destroy_all
puts 'Previous seed cleaned'

puts '*********************'

puts 'Create users'

5.times do
  user = User.new
  user.username = Faker::FunnyName.name
  user.email = Faker::Internet.email
  user.password = 'password'
  user.password_confirmation = 'password'
  user.save
end

admin_user = User.new
admin_user.username = Faker::FunnyName.name
admin_user.email = Faker::Internet.email
admin_user.password = 'password'
admin_user.password_confirmation = 'password'
admin_user.admin = true
admin_user.save

puts 'Users created'

User.all.each { |user| p user.email }
