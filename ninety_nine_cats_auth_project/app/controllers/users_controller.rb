class UsersController < ApplicationController

   def new
        @users = User.new
        render :new
   end

   def create
        # debugger
        @user = User.new(user_params)
        # debugger
        if @user.save
            redirect_to cats_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
   end


   private

   def user_params
    params.require(:user).permit(:user_name, :password)
   end
end