class ApplicationController < ActionController::Base
  before_action :default_format_json

  private

  def page
    params[:page]
  end

  def default_format_json
    request.format = "json"
  end
end
