require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!



describe ReviewsController, type: :controller do
  include Devise::Test::IntegrationHelpers
  # user should not be able to review a product that he has yet bought
  shared_context 'preparing records' do 
    let!(:seller) do 
      u = FactoryBot.create(:user, first_name: 'Khoa', last_name: 'khoa', username: 'khoa_seller', password: 'password', email: 'khoa@gmail.com')
      u.add_role :seller 
      u
    end
    let!(:buyer) do 
      u = FactoryBot.create(:user, first_name: 'Khoa', last_name: 'khoa', username: 'khoa_buyer', password: 'password', email: 'damanhkhoa@gmail.com')
      u.add_role :buyer
      u
    end
    let!(:buyer_two) do 
      u = FactoryBot.create(:user, first_name: 'Khoa', last_name: 'khoa', username: 'khoa_buyer_two', password: 'password', email: 'damanhkhoakhoa@gmail.com')
      u.add_role :buyer
      u
    end

    let!(:categories) { [FactoryBot.create(:category)] }
    let!(:bought_product) { FactoryBot.create(:product, title: 'laptop', description: 'some long text', price: 1000, stock: 2, published: true, on_sale: true, categories: categories, seller: seller) }
    let!(:not_bought_product) { FactoryBot.create(:product, title: 'desktop', description: 'some long text', price: 1000, stock: 2, published: true, on_sale: true, categories: categories, seller: seller) }
    
    let!(:order) { FactoryBot.create(:order, user: buyer )}
    let!(:order_item) { FactoryBot.create(:order_item, user: buyer, product: bought_product, quantity: 1, order: order )}
    
  end

    before(:each) do 
      
    end

  #
  # user should be able to review a product that he bought
  context "User did not buy product" do 
    include_context "preparing records"

    it 'should not be able to review the product' do
      controller.sign_in(buyer_two)

      params = {
        review: { 
          title: 'awesome', 
          body: 'super super long', 
          order_item_id: order_item.id,    
          rating: 5
        }  
      }
      post :create, params: params
      expect(response).to have_http_status(:redirect)
    end
  end

  context "User bought product" do 
    include_context "preparing records"

    it 'should be able to review the product' do
      controller.sign_in(buyer)
      params = {
        review: { 
          title: 'awesome', 
          body: 'super super long', 
          order_item_id: order_item.id,    
          rating: 5
        }  
      }
      post :create, params: params
      expect(response).to have_http_status(:ok)
    end


    it 'should not be able to review the product because missing fields' do
      controller.sign_in(buyer)
      params = {
        review: { 
          title: 'awesome', 
          body: 'super super long', 
          rating: 5
        }  
      }
      post :create, params: params
      expect(response).to have_http_status(:redirect)
    end


  end
end