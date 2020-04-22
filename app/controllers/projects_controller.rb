class ProjectsController < ApplicationController
  def index
    @projects = LawProject.page(page)

    @link = projects_url + next_page_number
  end

  def scrap_data
    ScrapingService.scrap_camara_nh

    render json: { message: "Atualizando os dados" }, status: 200
  end

  private

  def next_page_number
    page = (@projects.last_page? ? :current_page : :next_page)

    "?page=#{@projects.send(page)}"
  end
end
