class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

def self.devise_parameter_sanitizer
  super + [:phone_number]
end
          
enum role: { user: nil, admin: "1" }

def admin?
  role == 'admin'
end

def user?
  role.nil? || role == 'user'
end


end
