class UsersController < ApplicationController

  def show
    @user = User.includes(:skills).find(params[:id])
    @hours = @user.hours + [Hour.new]
  end

end