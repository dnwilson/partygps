class PagesController < ApplicationController
  skip_load_and_authorize_resource
  
  def home
  end

  def search
    @pg_search_documents = PgSearch.multisearch(params[:query])
    @query = params[:query]
  end

  def contact
  end

  def about
  end
end
