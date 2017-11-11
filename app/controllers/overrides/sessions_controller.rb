module Overrides

  class SessionsController < DeviseTokenAuth::SessionsController

    #skip_before_action :authenticate_user_with_filter
    before_action :set_country_by_ip, :only => [:create]
    before_action :create_facebook_user, :only => [:create]

    def create
      # Check
      field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first
      @resource = nil
      if field
        q_value = resource_params[field]

        if resource_class.case_insensitive_keys.include?(field)
          q_value.downcase!
        end

        #q = "#{field.to_s} = ? AND provider='email'"
        q = "#{field.to_s} = ? AND provider='#{params[:provider]}'"

        #if ActiveRecord::Base.connection.adapter_name.downcase.starts_with? 'mysql'
        #  q = "BINARY " + q
        #end

        @resource = resource_class.where(q, q_value).first
      end

      #sign in will be successful if @resource exists (matching user was found) and is a facebook login OR (email login and password matches)
      if @resource and (params[:provider] == 'facebook' || (valid_params?(field, q_value) and @resource.valid_password?(resource_params[:password]) and (!@resource.respond_to?(:active_for_authentication?) or @resource.active_for_authentication?)))
        # create client id
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @resource.tokens[@client_id] = { token: BCrypt::Password.create(@token), expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i }
        @resource.save

        sign_in(:user, @resource, store: false, bypass: false)

        yield @resource if block_given?

        render json: { message: "login successfully", code: "200", data: UserSerializer.new(@resource).serializable_hash }
      elsif @resource and not (!@resource.respond_to?(:active_for_authentication?) or @resource.active_for_authentication?)
        render_create_error_not_confirmed
      else
        #render_create_error_bad_credentials
        render json: {code: "500", message: "Email or password is incorrect"}
      end
    end

    def set_country_by_ip
      if !params['fb_code'].blank?

        if !params['user_ip'].blank?
          #checks if IP sent is valid, otherwise raise an error
          raise 'Invalid IP' unless (params['user_ip'] =~ Resolv::IPv4::Regex ? true : false)
          country_code = Custom::FacesLibrary.get_country_by_ip(params['user_ip'])
          country_id = Country.find_by(country_code: country_code)
          if country_id
            params.merge!(country_id: country_id.id, country_name: country_id.name, test: 'Test')
            I18n.locale = country_id.language_code
          else
            params.merge!(country_id: 1, country_name: 'International')
          end
        else
          params.merge!(country_id: 1, country_name: 'International')
        end

      end
    end

    def create_facebook_user

      if !params['fb_code'].blank?

        # TODO capture errors for invalid, expired or already used codes to return beter errors in API
        user_info, access_token = Omniauth::Facebook.authenticate(params['fb_code'])
        if user_info['email'].blank?
          Omniauth::Facebook.deauthorize(access_token)
        end
        #if Facebook user does not exist create it
        @user = User.find_by('uid = ? and provider = ?', user_info['id'], 'facebook')
        if !@user
          @graph = Koala::Facebook::API.new(access_token, ENV['FACEBOOK_APP_SECRET'])
          Koala.config.api_version = "v2.6"
          new_user_picture = @graph.get_picture_data(user_info['id'], type: :normal)
          new_user_info = {
                            uid: user_info['id'],
                            provider: 'facebook',
                            email: user_info['email'],
                            name: user_info['name'],
                            first_name: user_info['first_name'],
                            last_name: user_info['last_name'],
                            image: new_user_picture['data']['url'],
                            gender: user_info['gender'],
                            fb_auth_token: access_token,
                            friend_count: user_info['friends']['summary']['total_count'],
                            friends: user_info['friends']['data']
          }
          @user = User.new(new_user_info)
          @user.password = Devise.friendly_token.first(8)
          @user.country_id = params['country_id']
          @user.country_name = params['country_name']

          if !@user.save
            render json: @user.errors, status: :unprocessable_entity
          end
        end
        #regardless of user creation, merge facebook parameters for proper sign_in in standard action

        params.merge!(provider: 'facebook', email: @user.email)

      else
        params.merge!(provider: 'email')
      end
    end
  end

  def destroy
      # remove auth instance variables so that after_action does not run
      user = remove_instance_variable(:@resource) if @resource
      client_id = remove_instance_variable(:@client_id) if @client_id
      remove_instance_variable(:@token) if @token

      if user && client_id && user.tokens[client_id]
        user.tokens.delete(client_id)
        user.save!

        yield user if block_given?

        render_destroy_success
      else
        render_destroy_error
      end
  end

  private
  def render_destroy_success
    render json: {
      code: 200, message: "Logout successfully"
    }
  end

  def render_destroy_error
    render json: {
      code: 500, message: "User not found"
    }
  end
end