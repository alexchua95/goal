class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @hours = @user.hours + [Hour.new]
  end

end