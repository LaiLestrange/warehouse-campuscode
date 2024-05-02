require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
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
                          estimated_delivery_date: 1.day.from_now)


    #Act
    visit edit_order_path(order.id)

    #assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
   #Arrange
   user = User.create!(name: "Cliente1", email: "email1@cliente.com", password: 'cl13n73')

   first_supplier = Supplier.create!(corporate_name: 'Empresa X nome oficial registrado',
                               brand_name: 'Fantasia EMPRESA X',
                               registration_number: '123465789-00',
                               full_address: 'Rua abc, 540',
                               city: 'Cidade',
                               state: 'UE',
                               email: 'empresax@email.com')
   second_supplier = Supplier.create!(corporate_name: 'Empresa Y nome oficial registrado',
                               brand_name: 'Fantasia EMPRESA Y',
                               registration_number: '123465789-01',
                               full_address: 'Rua abc, 540',
                               city: 'Cidade',
                               state: 'UE',
                               email: 'empresay@email.com')
   warehouse = Warehouse.create!(name: 'Aeroporto SP',
                                 code:  'GRU',
                                 city: 'Guarulhos',
                                 area:100_000,
                                 address: 'Avenida do Aeroporto, 1000',
                                 cep: '15000-000',
                                 description: 'Galpão destinado para cargas internacionais')
   order = Order.create!(user: user,
                         warehouse: warehouse,
                         supplier: first_supplier,
                         estimated_delivery_date: 1.day.from_now)



    #Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: 3.weeks.from_now
    select second_supplier.corporate_name, from: 'Fornecedor'
    click_on 'Gravar'


    #assert
    expect(page).to have_content 'Pedido atualizado com sucesso!'
    expect(page).to have_content "Fornecedor: #{second_supplier.corporate_name}"
    formatted_date = I18n.localize(3.weeks.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end

  it 'caso seja o responsável' do
   #Arrange
   first_user = User.create!(name: "Cliente1", email: "email1@cliente.com", password: 'cl13n73')
   second_user = User.create!(name: "Cliente2", email: "email2@cliente.com", password: 'cl13n73')

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
   order = Order.create!(user: first_user,
                         warehouse: warehouse,
                         supplier: supplier,
                         estimated_delivery_date: 1.day.from_now)



    #Act
    login_as second_user
    visit edit_order_path(order.id)

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content "Você não tem permissão para acessar essa página!"
  end


end
