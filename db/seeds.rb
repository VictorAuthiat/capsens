# #FactoryBot.create_list(:user, 6)
# puts 'Users created'
# FactoryBot.create_list(:category, 5)
# puts 'Categories created'
# FactoryBot.create_list(:project, 10)
# puts 'Projects created'
# FactoryBot.create_list(:counterpart, 5)
# puts 'Counterparts created'
FactoryBot.create_list(:contribution, 30)
puts 'Contributions created'
AdminUser.create!(email: 'admin@capsens.eu', password: 'password', password_confirmation: 'password') if Rails.env.development?
