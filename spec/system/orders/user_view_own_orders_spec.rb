require 'rails_helper'

describe "Usuário vê seus próprios pedidos" do
  it "e deve estar autenticado" do
    #Arrange

    #Act
    visit root_path
    click_on 'Meus Pedidos'

    #Assert
    expect(current_path).to eq new_user_session_path

  end
  it "e não vê outros pedidos" do
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
    first_order = Order.create!(user: first_user,
                          warehouse: warehouse,
                          supplier: supplier,
                          estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: first_user,
                          warehouse: warehouse,
                          supplier: supplier,
                          estimated_delivery_date: 1.week.from_now)
    third_order = Order.create!(user: second_user,
                          warehouse: warehouse,
                          supplier: supplier,
                          estimated_delivery_date: 1.month.from_now)

    #Act
    login_as first_user
    visit root_path
    click_on 'Meus Pedidos'

    #Assert
    expect(page).to have_content first_order.code
    expect(page).to have_content second_order.code
    expect(page).not_to have_content third_order.code
  end

  it 'e visita um pedido' do
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
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    #assert

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content order.code
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end
  it 'e não visita pedidos de outros usuários' do
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
    first_order = Order.create!(user: first_user,
                          warehouse: warehouse,
                          supplier: supplier,
                          estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: first_user,
                          warehouse: warehouse,
                          supplier: supplier,
                          estimated_delivery_date: 1.week.from_now)
    third_order = Order.create!(user: second_user,
                          warehouse: warehouse,
                          supplier: supplier,
                          estimated_delivery_date: 1.month.from_now)



       #Act
       login_as second_user
       visit order_path(first_order.id)

       #Assert
       expect(current_path).not_to eq order_path(first_order.id)
       expect(current_path).to eq root_path
       expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

end
