class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
    @hours = @user.hours + [Hour.new]
  end

end