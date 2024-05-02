require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
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
    patch(order_path(order.id), params: {order: {supplier_id: 3}})

    #assert
    expect(response).to redirect_to(root_path)
  end
end
