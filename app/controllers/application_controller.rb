class ApplicationController < ActionController::API
  def user_credentials
    keys = %w[nome cognome email password]
    user_params = select_params(params, keys)
    user_params
  end

  # This method takes the params receive from Axiom and then select those necessary for creating an object.
  def select_params params, keys
    model ={}
    params.each do |key, value|
      if keys.include? key
        model[key]=value
      end
    end
    model
  end
end
