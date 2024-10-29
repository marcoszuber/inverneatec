# lib/tasks/contract_notifications.rake
namespace :contracts do
  desc "Enviar notificaciones para contratos próximos a vencer en 30 días"
  task notify_expiring: :environment do
    # Cambia Contract por Contrato
    contratos = Contrato.where("vigencia_fin = ?", Date.today + 30)

    contratos.each do |contrato|
      ContractMailer.contract_expiring(contrato).deliver_now
    end
  end
end
