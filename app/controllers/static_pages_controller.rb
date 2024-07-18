class StaticPagesController < ApplicationController
  def show
    @page = StaticPage.find_by(title: params[:title])
  end
end
