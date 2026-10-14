# Gestão da lojinha da pessoa logada (/perfil/minha-lojinha).
class MyStoresController < ApplicationController
  before_action :set_store

  def show
  end

  def edit
  end

  def update
    if @store.update(store_params)
      redirect_to my_store_path, notice: "Lojinha atualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_store
      @store = Current.user.store || Current.user.create_store!(name: "lojinha de #{Current.user.first_name.downcase}")
    end

    def store_params
      params.expect(store: %i[ name slug bio ])
    end
end
