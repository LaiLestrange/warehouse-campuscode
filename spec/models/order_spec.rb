require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#valid?" do
    it "deve ter um código" do
      #arrange
      user = User.create!(name: "Cliente", email: "email@cliente.com", password: 'cl13n73')
      supplier = Supplier.create!(
        corporate_name: 'Empresa X nome oficial registrado',
        brand_name: 'Fantasia EMPRESA X',
        registration_number: '123465789-00',
        full_address: 'Rua abc, 540',
        city: 'Cidade',
        state: 'UE',
        email: 'empresax@email.com'
        )
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code:  'GRU',
        city: 'Guarulhos',
        area:100_000,
        address: 'Avenida do Aeroporto, 1000',
        cep: '15000-000',
        description: 'Galpão destinado para cargas internacionais'
        )
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
      #act
      result = order.valid?
      #assert
      expect(result).to eq true
    end
    it "data estimada de entrega deve ser obrigatória" do
      #arrange
      order = Order.new(estimated_delivery_date: '')
      #act
      order.valid?
      result = order.errors.include? :estimated_delivery_date
      #assert
      expect(result).to be true
    end
    it "data estimada de entrega não deve ser passado" do
      #arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)
      #act
      order.valid?
      result = order.errors.include? :estimated_delivery_date
      #assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include " deve ser futura."
    end

    it "data estimada de entrega não deve ser hoje" do
      #arrange
      order = Order.new(estimated_delivery_date: Date.today)
      #act
      order.valid?
      result = order.errors.include? :estimated_delivery_date
      #assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include " deve ser futura."
    end
    it "data estimada de entrega não deve ser hoje" do
      #arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      #act
      order.valid?
      result = order.errors.include? :estimated_delivery_date
      #assert
      expect(result).to be false
    end
  end

  describe "gera um código aleatório" do
    it 'ao criar um novo pedido' do
      #arrange
      user = User.create!(name: "Cliente", email: "email@cliente.com", password: 'cl13n73')
      supplier = Supplier.create!(
        corporate_name: 'Empresa X nome oficial registrado',
        brand_name: 'Fantasia EMPRESA X',
        registration_number: '123465789-00',
        full_address: 'Rua abc, 540',
        city: 'Cidade',
        state: 'UE',
        email: 'empresax@email.com'
        )
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code:  'GRU',
        city: 'Guarulhos',
        area:100_000,
        address: 'Avenida do Aeroporto, 1000',
        cep: '15000-000',
        description: 'Galpão destinado para cargas internacionais'
        )
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.month.from_now)
      #act
      order.save!
      result = order.code
      #assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8

    end
    it 'e o código é único' do
      #arrange
      user = User.create!(name: "Cliente", email: "email@cliente.com", password: 'cl13n73')
      supplier = Supplier.create!(
        corporate_name: 'Empresa X nome oficial registrado',
        brand_name: 'Fantasia EMPRESA X',
        registration_number: '123465789-00',
        full_address: 'Rua abc, 540',
        city: 'Cidade',
        state: 'UE',
        email: 'empresax@email.com'
        )
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code:  'GRU',
        city: 'Guarulhos',
        area:100_000,
        address: 'Avenida do Aeroporto, 1000',
        cep: '15000-000',
        description: 'Galpão destinado para cargas internacionais'
        )
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.weeks.from_now)
      #act
      second_order.save!
      #assert
      expect(second_order.code).not_to eq first_order.code

    end
  end
end
