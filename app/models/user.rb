class User < ApplicationRecord
  has_many :products, foreign_key: :seller_id
  rolify
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  private
  def set_default_role
    self.roles ||= Role.find_by_name('buyer')
  end
end
