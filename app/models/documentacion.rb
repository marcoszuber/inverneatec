class Documentacion < ApplicationRecord
  belongs_to :user

  # Validaciones
  validates :titulo, presence: true


  # Configuración de subida de archivo PDF (opcional, usar gemas como CarrierWave o Active Storage)
  # Si usas Active Storage:
  belongs_to :user
  has_one_attached :archivo

  # Si usas CarrierWave:
  # mount_uploader :pdf, PdfUploader
end
