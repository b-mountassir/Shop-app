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
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

 
  attr_writer :login

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])

    unless user
      first_name = ""
      last_name = ""
      if data.has_key?('first_name') && data.has_key?('last_name')
        first_name = data['first_name']
        last_name = data['last_name']
      end
      user = User.create(
          email: data['email'],
          username: data['email'].split("@").first,
          first_name: first_name,
          last_name: last_name,
          password: Devise.friendly_token[0,20],
          roles: [Role.find_by(name: "buyer")]
      )
      
    end
    user
  end

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
