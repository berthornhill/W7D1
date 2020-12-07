class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        user = User.find_by_credentials(session_params[:username], session_params[:password])

        # if a user is found
        if user
            # log in the user with new session token
            session[:session_token] = user.reset_session_token!
            redirect_to cats_url
        else
            flash.now[:errors] = ['Invalid Credentials']
            render :new
        end
    end

    def destroy
        current_user.reset_session_token! 
        session[:session_token] = nil

        redirect_to session_url
    end

    private

    def session_params
        params.require(:user).permit(:username, :password)
    end
end