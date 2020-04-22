class ProjectsController < ApplicationController
  def index
    @projects = LawProject.page(page)

    @next_page = next_page_url
    @prev_page = prev_page_url
  end

  def scrap_data
    ScrapingService.scrap_camara_nh

    render json: { message: "Atualizando os dados" }, status: 200
  end

  private

  def next_page_url
    return if @projects.last_page? || @projects.next_page.nil?

    projects_url + "?page=#{@projects.next_page}"
  end

  def prev_page_url
    return if @projects.first_page?

    projects_url + "?page=#{@projects.prev_page}"
  end
end
