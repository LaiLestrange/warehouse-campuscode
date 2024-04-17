require 'rails_helper'

describe "Usuário cadastra um modelo de produto" do
  it "com sucesso" do
    #Arrange
    user = User.create!(name: "Fulane", email: "fu@lane.com", password: "pass1w0rd")
    login_as(user)
    first_supplier = Supplier.create!(
      corporate_name: 'Nome Empresa 1 Oficial LTDA',
      brand_name: 'Empresa 1',
      registration_number: '10',
      full_address: 'Rua das Empresas, 1',
      city: 'Empresarial',
      state: 'EM',
      email: 'empresa1@empresas.com'
    )

    second_supplier = Supplier.create!(
      corporate_name: 'Nome Empresa 2 Oficial LTDA',
      brand_name: 'Empresa 2',
      registration_number: '20',
      full_address: 'Rua das Empresas, 2',
      city: 'Empresarial',
      state: 'EM',
      email: 'empresa2@empresas.com'
    )
    #Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'Produto A'
    fill_in 'Peso', with: '10'
    fill_in 'Largura', with: '11'
    fill_in 'Altura', with: '12'
    fill_in 'Profundidade', with: '13'
    fill_in 'SKU', with: 'A10111213'
    select first_supplier.brand_name, from: 'Fornecedor' #escolher um
    select second_supplier.brand_name, from: 'Fornecedor' #e comentar o outro
    click_on 'Criar Modelo de Produto'
    #Assert
    expect(page).to have_content 'Modelo de Produto cadastrado com sucesso!'
    expect(page).to have_content 'Produto A'
    expect(page).to have_content 'A10111213'
    expect(page).to have_content 'Peso: 10g'
    expect(page).to have_content 'Dimensão: 11cm x 12cm x 13cm'
    expect(page).to have_content 'Fornecedor: Empresa 2' #ajustar qual recebe
  end

  it 'deve preencher todos os campos' do
    #Arrange
    user = User.create!(name: "Fulane", email: "fu@lane.com", password: "pass1w0rd")
    login_as(user)
    Supplier.create!(
      corporate_name: 'Nome Empresa 1 Oficial LTDA',
      brand_name: 'Empresa 1',
      registration_number: '10',
      full_address: 'Rua das Empresas, 1',
      city: 'Empresarial',
      state: 'EM',
      email: 'empresa1@empresas.com'
    )

    #Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    click_on 'Criar Modelo de Produto'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto!'
  end

end
