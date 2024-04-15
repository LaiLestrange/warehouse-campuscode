require 'rails_helper'

describe 'Usuário vê os detalhes de um fornecedor' do
  it 'e vê informações adicionais' do
    #arrange
    supplier = Supplier.create!(
      corporate_name: 'Empresa X nome oficial registrado',
      brand_name: 'Fantasia EMPRESA X',
      registration_number: '123465789-00',
      full_address: 'Rua abc, 540',
      city: 'Cidade',
      state: 'UE',
      email: 'empresax@email.com'
    )

    #act
    visit suppliers_path
    click_on supplier.brand_name

    #assert
    expect(page).to have_content('Fornecedor')
    expect(page).to have_content(supplier.brand_name)
    expect(page).to have_content(supplier.corporate_name)
    expect(page).to have_content(supplier.registration_number)
    expect(page).to have_content(supplier.full_address)
    expect(page).to have_content(supplier.city)
    expect(page).to have_content(supplier.state)
    expect(page).to have_content(supplier.email)
  end
  it 'e volta para a tela inicial' do
    #arrange
    supplier = Supplier.create!(
      corporate_name: 'Empresa X nome oficial registrado',
      brand_name: 'Fantasia EMPRESA X',
      registration_number: '123465789-00',
      full_address: 'Rua abc, 540',
      city: 'Cidade',
      state: 'UE',
      email: 'empresax@email.com'
    )

    #act
    visit suppliers_path
    click_on supplier.brand_name
    click_on 'Voltar'

    #assert
    expect(current_path).to eq root_path
  end
end
