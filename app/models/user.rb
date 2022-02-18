class User < ApplicationRecord
  has_many :products, foreign_key: :seller_id
  has_many :seller_orders, foreign_key: :seller_id
  has_one_attached :profile_picture
  has_many :reviews, foreign_key: :reviewer_id, dependent: :delete_all
  rolify
  has_many :orders, dependent: :delete_all
  has_many :order_items
  before_create :set_default_role
  validates :email, uniqueness: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 
  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  private

  def set_default_role
    self.roles ||= Role.find_by_name('buyer')
  end
end
