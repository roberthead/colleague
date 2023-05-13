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
  end

  def create
    @employer = resume.employers.new(employer_params)

    if @employer.save
      redirect_to resume_employers_path(resume_id: resume.slug, id: @employer.slug), notice: I18n.t("employer.created")
    else
      render :new, alert: I18n.t("employer.not_created")
    end
  end

  def update
    if employer.update(employer_params)
      redirect_to resume_employer_path(resume, employer), notice: I18n.t("employer.updated")
    else
      flash.now[:alert] = I18n.t("employer.not_updated")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    employer.destroy
    redirect_to resume_employers_path(resume), notice: I18n.t("employer.deleted")
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
    params.require(:employer).permit(:name, :location, :url).merge(resume: resume)
  end
end
