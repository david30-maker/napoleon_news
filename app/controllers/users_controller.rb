class UsersController < ApplicationController
  def index
    head :unauthorized unless current_user&.admin?

    @users = User.page(params[:page]).per(3)
  end

  def update_role
    user = User.find(params[:id])
    role = params[:role]

    if user.update(role: role)
      redirect_to users_path, notice: "#{user.first_name} is now a #{role.capitalize}."
    else
      redirect_to users_path, alert: "Failed to update role for #{user.first_name}."
    end
  end
end