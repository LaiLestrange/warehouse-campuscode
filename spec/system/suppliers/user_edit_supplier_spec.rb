require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página inicial' do
    #arrange
    supplier = Supplier.create!(
      corporate_name: 'Nome Empresa 1 Oficial LTDA',
      brand_name: 'Empresa 1',
      registration_number: '10',
      full_address: 'Rua das Empresas, 1',
      city: 'Empresarial',
      state: 'EM',
      email: 'empresa1@empresas.com'
    )

    #act
    visit root_path
    click_on 'Fornecedores'
    click_on supplier.brand_name
    click_on 'Editar'

    #assert
    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Nome da Empresa', with: supplier.corporate_name)
    expect(page).to have_field('Nome Fantasia', with: supplier.brand_name)
    expect(page).to have_field('CNPJ', with: supplier.registration_number)
    expect(page).to have_field('Endereço', with: supplier.full_address)
    expect(page).to have_field('Cidade', with: supplier.city)
    expect(page).to have_field('Estado', with: supplier.state)
    expect(page).to have_field('E-mail', with: supplier.email)
  end

  it 'com sucesso' do
    #arrange
    supplier = Supplier.create!(
      corporate_name: 'Nome Empresa 1 Oficial LTDA',
      brand_name: 'Empresa 1',
      registration_number: '10',
      full_address: 'Rua das Empresas, 1',
      city: 'Empresarial',
      state: 'EM',
      email: 'empresa1@empresas.com'
    )

    #act
    visit root_path
    click_on 'Fornecedores'
    click_on supplier.brand_name
    click_on 'Editar'
    fill_in 'Nome da Empresa', with: 'Nome Empresa 2 Oficial LTDA'
    fill_in 'Nome Fantasia', with: 'Empresa 2'
    fill_in 'CNPJ', with: '12'
    fill_in 'Endereço', with: 'Rua das Empresas, 2'
    fill_in 'E-mail', with: 'empresa2@empresas.com'
    click_on 'Atualizar Fornecedor'

    #assert
    expect(page).to have_content('Fornecedor atualizado com sucesso!')
    expect(page).to have_content('Empresa 2')
    expect(page).to have_content('Nome Empresa 2 Oficial LTDA')
    expect(page).to have_content('12')
    expect(page).to have_content('Rua das Empresas, 2')
    expect(page).to have_content('Empresarial')
    expect(page).to have_content('EM')
    expect(page).to have_content('empresa2@empresas.com')

  end

  it 'e mantém campos obrigatórios' do
    #arrange
    supplier = Supplier.create!(
      corporate_name: 'Nome Empresa 1 Oficial LTDA',
      brand_name: 'Empresa 1',
      registration_number: '10',
      full_address: 'Rua das Empresas, 1',
      city: 'Empresarial',
      state: 'EM',
      email: 'empresa1@empresas.com'
    )

    #act
    visit root_path
    click_on 'Fornecedores'
    click_on supplier.brand_name
    click_on 'Editar'
    fill_in 'Nome da Empresa', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Atualizar Fornecedor'

    #assert
    expect(page).to have_content('Não foi possível atualizar o fornecedor!')

  end
end
