require 'net/http' #SEGUN LO QUITÓ PERO CREEMOS QUE LO DEJÓ
class Authentication::UsersController < ApplicationController
    skip_before_action :protect_pages
    def new 
        @user = User.new
    end 

    def create 
        @user = User.new(user_params)
        uri = URI("http://ip-api.com/json/24.48.0.1")
        response = Net::HTTP.get(uri)
        parsed_response = JSON.parse(response)
        country_code = parsed_response.dig("countryCode")
        pp country_code
        if @user.save
            FetchCountryJob.perform_later(@user.id, request.remote_ip)
            UserMailer.with(user: @user).welcome.deliver_later
            session[:user_id] = @user.id
            redirect_to products_path, notice: 'El usuario ha sido creado'
        else
            render :new, status: :unprocessable_entity
        end 
    end
  
    private
    def user_params
        params.require(:user).permit(:email, :username, :password)
    end

end