class Precio < ApplicationRecord
  validates :categoria, presence: true

  # Add any other validations or associations as needed

  scope :latest, -> { order(created_at: :desc).limit(1) }
end
