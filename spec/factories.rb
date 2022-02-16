FactoryBot.define do

  factory :user do
    first_name { first_name }
    last_name  { last_name }
    username { username }
    password { password }
    email { email } 
    confirmed_at { Time.now.utc }
  end

  factory :category do 
    name { 'laptop' }
  end

  factory :product do 
    title { title }
    description { description }
    price { price }
    stock { stock }
    published { published }
    on_sale { on_sale }
    category_ids { categories.map(&:id) }
    seller { seller }
  end
  
  factory :order_item do
    user { user }
    product { bought_product }
    quantity { quantity }
    order { order }
  end

  factory :order do
    user { user }
    status { 1 }
  end

end