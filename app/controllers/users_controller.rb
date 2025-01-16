class UsersController < ApplicationController
  def index
    head :unauthorized unless current_user&.admin?

    @users = User.order(:first_name, :last_name).page(params[:page]).per(20)
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

  # def authored_articles
  #   head :unauthorized unless current_user&.admin? || current_user.id == params[author

  #   @author = User.find(params[:author_id])
  #   @articles = @author.authored_articles.order(created_at: :desc).page(params[:page]).per(50)
  # end
end