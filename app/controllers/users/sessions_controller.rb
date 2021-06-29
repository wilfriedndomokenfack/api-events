# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def create
    user = User.find_by_email(user_credentials["email"]) # user_credentials is implemented in application controller
    if user && user.valid_password?(user_credentials["password"])
      if user.email_confirmed?
        token = user.generate_jwt
        render json: {message: token, flag: 1}
      else
        mesg = "Deve confermare il suo indirizzo email prima di continuare"
        render json: {message: mesg, flag: 2}
      end
    else
      mesg = "E-mail non esistente o  password sbagliata"
      render json: { message: mesg, flag: 3 }
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
