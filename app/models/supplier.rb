class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
  validates :state, length: {is: 2}
  validates :registration_number, uniqueness: true
end
