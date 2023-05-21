class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_user

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: I18n.t("profile.updated")
    else
      flash.now[:alert] = I18n.t("profile.not_updated")
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :preferred_pronouns, :portfolio_url)
  end

  def assign_user
    @user = current_user
  end
end
