class ResumesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_resume, only: [:show, :edit, :update, :destroy]

  def index
    @resumes = Resume.all.order(created_at: :desc)
  end

  def show
  end

  def new
    authorize Resume, :new?
    @resume = current_user.resumes.new
  end

  def edit
    authorize @resume
  end

  def create
    authorize Resume, :create?
    @resume = current_user.resumes.new(resume_params.merge(user: current_user))
    if @resume.save
      respond_to do |format|
        format.html { redirect_to @resume, notice: I18n.t("resume.created") }
        format.turbo_stream { flash.now[:notice] = I18n.t("resume.created") }
      end
    else
      flash.now[:alert] = I18n.t("resume.not_created")
      render(:new, status: :unprocessable_entity)
    end
  end

  def update
    authorize @resume
    if @resume.update(resume_params)
      respond_to do |format|
        format.html { redirect_to resume_path(id: @resume.slug), notice: I18n.t("resume.updated") }
        format.turbo_stream { flash.now[:notice] = I18n.t("resume.updated") }
      end
    else
      flash.now[:alert] = I18n.t("resume.not_updated")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @resume
    if @resume.destroy
      respond_to do |format|
        format.html { redirect_to resumes_path, notice: I18n.t("resume.destroyed") }
        format.turbo_stream { flash.now[:notice] = I18n.t("resume.destroyed") }
      end
    else
      flash.now[:alert] = I18n.t("resume.not_destroyed")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def require_resume
    @resume = Resume.find_by(slug: params[:id]) || current_user&.resumes&.first
    return if @resume

    redirect_to(current_user ? new_resume_path : new_user_session_path)
  end

  def resume_params
    params.require(:resume).permit(:field, :profile, :email, :phone, :alias_name)
  end
end
