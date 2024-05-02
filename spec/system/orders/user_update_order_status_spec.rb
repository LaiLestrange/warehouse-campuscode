require 'rails_helper'

describe "Usuário informa novo status de pedido" do
  it "e pedido foi entregue" do
    #Arrange
    user = User.create!(name: "Cliente", email: "email@cliente.com", password: 'cl13n73')

    supplier = Supplier.create!(corporate_name: 'Empresa X nome oficial registrado',
                                brand_name: 'Fantasia EMPRESA X',
                                registration_number: '123465789-00',
                                full_address: 'Rua abc, 540',
                                city: 'Cidade',
                                state: 'UE',
                                email: 'empresax@email.com')
    warehouse = Warehouse.create!(name: 'Aeroporto SP',
                                  code:  'GRU',
                                  city: 'Guarulhos',
                                  area:100_000,
                                  address: 'Avenida do Aeroporto, 1000',
                                  cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    order = Order.create!(user: user,
                          warehouse: warehouse,
                          supplier: supplier,
                          estimated_delivery_date: 1.day.from_now,
                          status: :pending)
    #Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on "Marcar como ENTREGUE"

    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Situação do Pedido: Entregue"
    expect(page).to have_content "Pedido Entregue!"
  end
  it "e pedido foi cancelado" do
    #Arrange
    user = User.create!(name: "Cliente", email: "email@cliente.com", password: 'cl13n73')

    supplier = Supplier.create!(corporate_name: 'Empresa X nome oficial registrado',
                                brand_name: 'Fantasia EMPRESA X',
                                registration_number: '123465789-00',
                                full_address: 'Rua abc, 540',
                                city: 'Cidade',
                                state: 'UE',
                                email: 'empresax@email.com')
    warehouse = Warehouse.create!(name: 'Aeroporto SP',
                                  code:  'GRU',
                                  city: 'Guarulhos',
                                  area:100_000,
                                  address: 'Avenida do Aeroporto, 1000',
                                  cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    order = Order.create!(user: user,
                          warehouse: warehouse,
                          supplier: supplier,
                          estimated_delivery_date: 1.day.from_now,
                          status: :pending)
    #Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on "Marcar como CANCELADO"

    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Situação do Pedido: Cancelado"
    expect(page).to have_content "Pedido Cancelado!"
  end
end
