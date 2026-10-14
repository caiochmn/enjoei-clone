class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail subject: "Crie uma nova senha", to: user.email_address
  end
end
