FactoryBot.create_list(:user, 5)
puts 'Users created'
User.all.each { |user| p user.email }
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

