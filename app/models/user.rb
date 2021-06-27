class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  def generate_jwt
    minutes = 30
    JWT.encode({
        id: id, 
        nome: nome, 
        cognome: cognome, 
        email: email, 
        exp: minutes*60*1000
      }, 
      Rails.application.secrets.secret_key_base
    )
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
end
