# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "mb.bouyebla@gmail.com", password: "gagafour2!")
User.find(1).add_role :admin
Role.create(name: 'buyer')
Role.create(name: 'seller')
require 'faker'

20.times do 
    Category.create(name: Faker::Commerce.department)
end


PRODUCTS_COUNT = 100

MAX_CATEGORIES = 3

CATEGORIES = Category.all

PRODUCTS_COUNT.times do

  title = ''

  # generate unique title
  loop do
    title = Faker::Commerce.product_name
    break unless Product.exists?(title: title)
  end

  product = Product.new(
    title: title,
    stock: 20,
    price: Faker::Commerce.price,
    product_picture: Faker::LoremFlickr.unique.image
  )

  num_categories = 1 + rand(MAX_CATEGORIES)
  product.categories = CATEGORIES.sample(num_categories)
  product.seller = User.find(1)
  product.save!

end