class StoresController < ApplicationController
  allow_unauthenticated_access

  def show
    @store = Store.includes(:user).find_by!(slug: params[:id])
  end
end
