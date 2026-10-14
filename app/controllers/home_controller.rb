class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    @stores = Store.order(created_at: :desc).limit(8)
    @brands = Brand.order(:name).limit(12)
  end
end
