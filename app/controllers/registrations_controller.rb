class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_registration_path, alert: "Muitas tentativas. Tente de novo daqui a pouco." }
  before_action :redirect_signed_in_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user
      redirect_to my_store_path, notice: "Conta criada! Sua lojinha já está no ar."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.expect(user: %i[ name email_address password password_confirmation ])
    end

    def redirect_signed_in_user
      redirect_to root_path if authenticated?
    end
end
