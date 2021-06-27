# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end
  def create
    user = User.find_by_confirmation_token(params[:params][:confirmation_token])
    if user
        user.validate_email
        user.save(validate: false)
        render json: { message:  "Il suo indirizzo email è stato confermato con successo", flag: 1}
    else
        render json: { message: "Il suo indirizzo email è già stato confermato, prova ad accedere", flag: 2} # if flag=2 => the mail is already confirmed
    end 
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
