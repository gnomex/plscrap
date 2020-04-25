class ApplicationController < ActionController::Base
  private

  def page
    params[:page]
  end
end
