class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user.nil?
      mesg = "Email non existente"
      render json: {message: mesg, flag: 2}
    else
      user.send_reset_password_instructions # this line send an email to the user. The html of the email sent is views/devise/mailer/reset_password_instructions.html.erb
      user.save # this line save the token in the reset_password_token field and set the reset_password_sent_at with the current datetime
      mesg = "Istruzioni inviate per email"
      render json: {message: mesg, flag: 1}
    end
  end

  # PATCH http://localhost:3033/password_reset
  def update
    user = User.find_by_reset_password_token(params[:token]) # find the user with corresponding token sent previously
    if user.nil? # user non found
      mesg =  "User non existente"
      render json: {message: mesg, flag: 2}
    else # user found
      user.update_attribute(:password, params[:password]) # update the password
      user.save # 
      mesg =  "Password modificata con successo"
      render json: {message: mesg, flag: 1}
    end
  end
end
