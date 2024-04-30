require 'rails_helper'

describe "Usuário busca por um pedido" do
  it "a partir do menu" do

    #arrange
    user = User.create!(name: "Cliente", email: "email@cliente.com", password: 'cl13n73')
    #act
    login_as user
    visit root_path

    #assert
    within('header nav') do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end
  it "e deve estar autenticado" do
    #arrange

    #act
    visit root_path

    #assert
    within('header nav') do
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end

  it "a partir do menu" do
    #arrange
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
                          estimated_delivery_date: 1.day.from_now)

    #act
    login_as user
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    #assert
      expect(page).to have_content "Resultados da Busca por: #{order.code}"
      expect(page).to have_content '1 pedido encontrado'
      expect(page).to have_content "Código: #{order.code}"
      expect(page).to have_content "Galpão Destino: #{warehouse.full_description}"
      expect(page).to have_content "Fornecedor: #{supplier.corporate_name}"
  end
end
