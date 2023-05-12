class ProfilesController < ApplicationController
  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path, notice: I18n.t("profile.updated")
    else
      render :show, alert: I18n.t("profile.not_updated")
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone)
  end
end
