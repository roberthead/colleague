class SchoolsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update destroy]
  before_action :require_resume
  before_action :require_permission, only: %i[new create edit update destroy]
  before_action :require_school, only: %i[show edit update destroy]

  def index
    @schools = resume.schools
  end

  def show
  end

  def new
    @school = resume.schools.new
  end

  def edit
  end

  def create
    authorize resume, :edit?
    @school = resume.schools.new(school_params)
    if @school.save
      respond_to do |format|
        format.html { redirect_to [resume, school], notice: I18n.t("school.created") }
        format.turbo_stream { flash.now[:notice] = I18n.t("school.created") }
      end
    else
      flash.now[:alert] = I18n.t("school.not_created")
      render(:new, status: :unprocessable_entity)
    end
  end

  def update
    authorize resume, :edit?
    if school.update(school_params)
      respond_to do |format|
        format.html {
          redirect_to resume_school_path(resume, school), notice: I18n.t("school.updated")
        }
        format.turbo_stream { flash.now[:notice] = I18n.t("school.updated") }
      end
    else
      flash.now[:alert] = I18n.t("school.not_updated")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize resume, :edit?
    if school.destroy
      respond_to do |format|
        format.html { redirect_to resume_schools_path(resume), notice: I18n.t("school.destroyed") }
        format.turbo_stream { flash.now[:notice] = I18n.t("school.destroyed") }
      end
    else
      flash.now[:alert] = I18n.t("school.not_destroyed")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def require_resume
    return if resume

    redirect_to resumes_path, alert: I18n.t("resume.not_found")
  end

  def resume
    @resume ||= Resume.find_by(slug: params[:resume_id])
  end

  def require_school
    return if school

    redirect_to resumes_path, alert: I18n.t("school.not_found")
  end

  def school
    @school ||= resume.schools.find_by(slug: params[:id])
  end

  def require_permission
    authorize resume, :edit?
  end

  def school_params
    params.require(:school).permit(
      :name, :location, :url, :major, :degree, :note
    ).merge(resume: resume)
  end
end
