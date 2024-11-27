class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user

    render plain: "Welcome #{@user.email} to Napoleon News!"
  end
end
