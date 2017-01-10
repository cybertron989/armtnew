class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :valid_user!


  def valid_user!
    # binding.pry
  end

end
