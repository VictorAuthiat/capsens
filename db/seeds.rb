FactoryBot.create_list(:user, 5)
FactoryBot.create_list(:category, 5)
FactoryBot.create_list(:project, 10)

puts 'Users created'
User.all.each { |user| p user.email }
AdminUser.create!(email: 'admin@capsens.eu', password: 'password', password_confirmation: 'password') if Rails.env.development?
