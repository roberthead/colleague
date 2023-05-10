class ResumesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_resume, only: [:show]
  # before_action :require_owned_resume, only: [:edit, :update, :destroy]

  def show
  end

  def new
  end

  def edit
  end

  def create
    @resume = current_user.resumes.new(resume_params.merge(user: current_user))
    if @resume.save
      redirect_to @resume, notice: I18n.t("resource.created", resource: resource_name).capitalize
    else
      flash.now[:alert] = I18n.t("resource.not_created", resource: resource_name)
      render(:new, status: :unprocessable_entity).capitalize
    end
  end

  def update
  end

  def destroy
  end

  private

  # def require_owned_resume
  #   @resume = current_user&.resumes&.find_by(id: params[:id])
  #   return if @resume

  #   redirect_to(redirect_path, {
  #     alert: I18n.t("resource.not_found", resource: resource_name).capitalize
  #   })
  # end

  def require_resume
    @resume = Resume.find_by(id: params[:id]) || current_user&.resumes&.first
    return if @resume

    redirect_to(redirect_path, {
      alert: I18n.t("resource.not_found", resource: resource_name).capitalize
    })
  end

  def redirect_path
    return new_resume_path if current_user

    new_user_session_path
  end

  def resume_params
    params.require(:resume).permit(:field, :profile)
  end
end
