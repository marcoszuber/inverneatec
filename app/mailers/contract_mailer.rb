# app/mailers/contract_mailer.rb
class ContractMailer < ApplicationMailer
  default from: 'notificaciones@yourdomain.com'

  def contract_expiring(contract)
    @contract = contract
    @owner = @contract.user

    # Usuarios con tipo "o" para recibir la notificación
    @operators = User.where(tipo_de_usuario: 'o')

    mail(
      to: @owner.email,
      cc: @operators.pluck(:email),
      subject: "Notificación: Contrato próximo a vencer en 30 días"
    )
  end
end
