class Warehouse < ApplicationRecord

  validates :name, :code, :city, :area, :address, :cep, :description, presence: true
  validates :code, length: { is: 3 }
  validates :code, uniqueness: true

end
