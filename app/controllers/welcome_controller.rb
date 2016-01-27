class WelcomeController < ApplicationController

  layout 'full_width'

  def index
    @landing = Landing.new
  end

end
