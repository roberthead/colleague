class ApplicationController < ActionController::Base
  include Pundit::Authorization

  private

  def resource_name
    I18n.t("activerecord.models.#{controller_name.singularize}")
  end
end
