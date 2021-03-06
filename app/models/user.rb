class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,

  :recoverable, :rememberable, :validatable, :omniauthable

  has_many :tasks, dependent: :destroy


  def self.connect_to_linkedin(auth, signed_in_resource=nil)
   user = User.where(:provider => auth.provider, :uid => auth.uid).first
   if user
     return user
   else
     registered_user = User.where(:email => auth.info.email).first
     if registered_user
       return registered_user
     else
       user = User.create(first_name:auth.info.first_name, last_name: auth.info.last_name, provider:auth.provider, uid:auth.uid, email:auth.info.email, password:Devise.friendly_token[0,20],
        )
     end
   end
 end

end