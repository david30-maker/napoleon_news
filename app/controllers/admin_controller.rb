class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    head :unauthorized unless current_user&.admin? || current_user&.editor?
  end
end