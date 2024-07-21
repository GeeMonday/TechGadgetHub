class StaticPagesController < ApplicationController
  def show
    # First, attempt to find a StaticPage by its title
    @page = StaticPage.find_by(title: params[:title])
    
    # If no page is found by title, fall back to finding by ID
    @page ||= StaticPage.find(params[:id]) if params[:id].present?
  end
end
