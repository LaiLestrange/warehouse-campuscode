require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    #arrange
    #act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    #assert

    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    #arrange
    first_supplier = Supplier.create!(
      corporate_name: 'Empresa X nome oficial registrado',
      brand_name: 'Fantasia EMPRESA X',
      registration_number: '123465789-00',
      full_address: 'Rua abc, 540',
      city: 'Cidade',
      state: 'UE',
      email: 'empresax@email.com'
    )
    second_supplier = Supplier.create!(
      corporate_name: 'Empresa Y nome oficial registrado',
      brand_name: 'Fantasia EMPRESA Y',
      registration_number: '234657891-00',
      full_address: 'Rua def, 541',
      city: 'Outra Cidade',
      state: 'OE',
      email: 'empresay@email.com'
    )
    #act
    visit root_path
    click_on 'Fornecedores'

    #assert
    expect(page).not_to have_content('Não existem fornecedores cadastrados!')
    
    expect(page).to have_content(first_supplier.brand_name)
    expect(page).to have_content(first_supplier.city)
    expect(page).to have_content(first_supplier.state)

    expect(page).to have_content(second_supplier.brand_name)
    expect(page).to have_content(second_supplier.city)
    expect(page).to have_content(second_supplier.state)
  end

  it 'e não existem fornecedores cadastrados' do
    #arrange

    #act
    visit root_path
    click_on 'Fornecedores'

    #assert
    expect(page).to have_content 'Não existem fornecedores cadastrados!'
  end
end
