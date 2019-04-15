# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Role.count<1
  Role.create(name: 'admin')
  Role.create(name: 'worker')

end

if Category.count <1
  Category.create(name: 'High Risk')
  Keyword.create(category_id: 1, name:'high risk')
  Category.create(name: 'Mother')
  Keyword.create(category_id: 2, name:'mother')
  Category.create(name: 'Child')
  Keyword.create(category_id: 3, name:'child')
  Category.create(name: 'Referral')
  Keyword.create(category_id: 4, name:'refer')
  Keyword.create(category_id: 4, name:'treatment')
  Category.create(name: 'Delivery')
  Keyword.create(category_id: 5, name:'delivery')
  Category.create(name: 'Stable')
  Keyword.create(category_id: 6, name:'normal')
  Keyword.create(category_id: 6, name:'teek')
  Category.create(name: 'Alert')
  Keyword.create(category_id: 7, name:'alert')
  Category.create(name: 'Anemia')
  Keyword.create(category_id: 7, name:'HB')
  Keyword.create(category_id: 7, name:'iron')
  Category.create(name: 'Malnutrition')
  Keyword.create(category_id: 8, name:'MUAC')
  Category.create(name: 'Uncoded')
end

User.create!(email:"admin@gmaila.com",account_activated:true, role_id:1, password:"ahujaetika10")





