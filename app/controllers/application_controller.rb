class ApplicationController < ActionController::API

        respond_to :json
        before_action :process_token

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

        # This function overrides the default devise sign_up_params
        #helper_method :sign_up_params # expose this method as a helper
        def user_credentials
          keys = %w[nome cognome email password]
          user_params = select_params(params, keys)
          user_params
        end

        private
        # Check for auth headers - if present, decode or send unauthorized response (called always to allow current_user)
        def process_token
          if request.headers['Authorization'].present?
            begin
              token = request.headers['Authorization'].split(' ')[1]
              #jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.secrets.secret_key_base).first
              jwt_payload = JWT.decode(token, nil, false)[0]
              @current_user_id = jwt_payload['id']
            rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
            head :unauthorized
            end
          end
        end

        # If user has not signed in, return unauthorized response (called only when auth is needed)
        def authenticate_user!(options = {})
          head :unauthorized unless signed_in?
        end

        # check that authenticate_user has successfully returned @current_user_id (user is authenticated)
        def signed_in?
          @current_user_id.present?
        end
        
end
