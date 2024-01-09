class Archivo < ApplicationRecord
  has_many :muestreos, dependent: :destroy
end
