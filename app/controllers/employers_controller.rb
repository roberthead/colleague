class EmployersController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update destroy]
  before_action :require_resume
  before_action :require_permission, only: %i[new create edit update destroy]
  before_action :require_employer, only: %i[show edit update destroy]

  def index
    @employers = resume.employers
  end

  def show
  end

  def new
    @employer = resume.employers.new
  end

  def edit
    employer.roles.new if employer.roles.empty?
  end

  def create
    authorize resume, :edit?
    @employer = resume.employers.new(employer_params)
    if @employer.save
      respond_to do |format|
        format.html { redirect_to [resume, employer], notice: I18n.t("employer.created") }
        format.turbo_stream { flash.now[:notice] = I18n.t("employer.created") }
      end
    else
      flash.now[:alert] = I18n.t("employer.not_created")
      render(:new, status: :unprocessable_entity)
    end
  end

  def update
    authorize resume, :edit?
    if employer.update(employer_params)
      respond_to do |format|
        format.html {
          redirect_to resume_employer_path(resume, employer), notice: I18n.t("employer.updated")
        }
        format.turbo_stream { flash.now[:notice] = I18n.t("employer.updated") }
      end
    else
      flash.now[:alert] = I18n.t("employer.not_updated")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize resume, :edit?
    if employer.destroy
      respond_to do |format|
        format.html { redirect_to resume_employers_path(resume), notice: I18n.t("employer.destroyed") }
        format.turbo_stream { flash.now[:notice] = I18n.t("employer.destroyed") }
      end
    else
      flash.now[:alert] = I18n.t("employer.not_destroyed")
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

  def require_employer
    return if employer

    redirect_to resumes_path, alert: I18n.t("employer.not_found")
  end

  def employer
    @employer ||= resume.employers.find_by(slug: params[:id])
  end

  def require_permission
    authorize resume, :edit?
  end

  def employer_params
    params.require(:employer).permit(
      :name, :location, :url,
      roles_attributes: [:id, :title, :accomplishments, :start_year, :end_year, :_destroy]
    ).merge(resume: resume)
  end
end
