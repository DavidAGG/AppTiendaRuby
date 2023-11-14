class Authentication::SessionsController < ApplicationController
    skip_before_action :protect_pages
    
    def new 
    end 

    def create 

        @user = User.find_by("email = :login OR username = :login", {login: params[:login]})
        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to products_path, notice: 'La sesion se ha iniciado'
        else
            redirect_to sessions_path, alert:  'Cuenta o contraseña son incorrectas'
        end
      
        
    end

    def destroy 
        session.delete(:user_id)

        redirect_to products_path, notice: 'Sesión finalizada'
    end
  
   

end