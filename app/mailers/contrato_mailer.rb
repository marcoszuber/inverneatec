class ContratoMailer < ApplicationMailer
  def nuevo_contrato_email(user, contrato)
    @user = user
    @contrato = contrato
    mail(to: @user.email, subject: 'Nuevo contrato creado')
  end
end
