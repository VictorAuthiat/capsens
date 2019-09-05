User.destroy_all
puts 'Previous seed cleaned'
FactoryBot.create_list(:user, 5)
puts 'Users created'
User.all.each { |user| p user.email }
