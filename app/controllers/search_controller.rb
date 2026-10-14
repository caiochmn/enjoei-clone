# Placeholder: a busca com filtros (q, dep, cat, b, pl, pg) chega na etapa 2 do roadmap.
class SearchController < ApplicationController
  allow_unauthenticated_access

  def index
    @query = params[:q].to_s.strip
  end
end
