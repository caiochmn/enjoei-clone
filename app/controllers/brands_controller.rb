class BrandsController < ApplicationController
  allow_unauthenticated_access

  def index
    @brands_by_letter = Brand.order(:name).group_by { |brand| brand.name[0].upcase }
  end
end
