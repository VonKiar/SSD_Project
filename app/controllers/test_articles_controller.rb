class TestArticlesController < ApplicationController
  #caches_page :index

  def index
    @articles = Article.all
  end
end