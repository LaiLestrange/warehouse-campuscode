require 'rails_helper'

describe "Usuário cadastra um pedido" do
  it 'e deve estar autenticado' do
    #arrange
    #act
    visit root_path
    click_on 'Registrar Pedido'
    #assert
    expect(current_path).to eq new_user_session_path
  end
  it "com sucesso" do
    #arrange
    user = User.create!(name: "Cliente", email: "email@cliente.com", password: 'cl13n73')

    Warehouse.create!(name: 'Aero Porto',
                      code:  'AEP',
                      city: 'Cidade',
                      area:20_000,
                      address: 'Avenida do Aeroporto, 102',
                      cep: '25000-000',
                      description: 'Galpão destinado para outras cargas'
                      )
    Supplier.create!(corporate_name: 'Empresa Y nome oficial registrado',
                      brand_name: 'Fantasia EMPRESA Y',
                      registration_number: '223465789-00',
                      full_address: 'Rua abcde, 541',
                      city: 'Cidade',
                      state: 'UE',
                      email: 'empresay@email.com'
                      )
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')

    #act
    login_as user
    visit root_path
    click_on 'Registrar Pedido'
    select warehouse.full_description, from: 'Galpão'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '28/05/2024'
    click_on 'Gravar'

    #asser
    expect(page).to have_content 'Pedido registrado com suceso.'
    expect(page).to have_content 'Pedido ABCD1234'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Empresa X nome oficial registrado'
    expect(page).to have_content 'Usuário Responsável: Cliente - email@cliente.com'
    expect(page).to have_content 'Data Prevista de Entrega: 28/05/2024'
    expect(page).not_to have_content 'Aero Porto'
    expect(page).not_to have_content 'Fantasia EMPRESA Y'
  end
end
