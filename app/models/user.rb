class User < ApplicationRecord
  rolify
  after_create :assign_default_role # assign a default role after creation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  

  def generate_jwt
    minutes = 30
    
    payload = {
        id: id, 
        nome: nome, 
        cognome: cognome, 
        email: email, 
        exp: minutes*60*1000
      }
    JWT.encode payload, nil, 'none'
  end

  # validates an email for a newly registered user
  def validate_email
    self.email_confirmed = true
    self.update(confirmed_at: DateTime.now)
    self.confirmation_token = nil
  end

  def email_confirmed?
    return self.email_confirmed
  end

  #assigns a default role (user) to a newly registered user
  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
