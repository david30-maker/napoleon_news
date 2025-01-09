class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    head :unauthorized unless current_user && !current_user.visitor?
  end
end