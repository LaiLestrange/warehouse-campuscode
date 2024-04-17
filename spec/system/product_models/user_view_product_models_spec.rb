require 'rails_helper'

describe "Usuário vê o modelos de produtos" do

    it 'se estiver autenticado' do
      #Arrange
      #Act
      visit root_path
      within('nav') do
        click_on 'Modelos de Produtos'
      end
      #Assert
      expect(current_path).to eq new_user_session_path
    end
    it "a partir do menu" do
      #Arrange
      user = User.create!(name: "Fulane", email: "fu@lane.com", password: "pass1w0rd")
      login_as(user)
      #Act
      visit root_path
      within('nav') do
        click_on 'Modelos de Produtos'
      end
      #Assert
      expect(current_path).to eq product_models_path
    end

    it 'com sucesso' do
      #Arrange
      user = User.create!(name: "Fulane", email: "fu@lane.com", password: "pass1w0rd")
      login_as(user)
        #criar modelos de produtos
      supplier_x = Supplier.create!(
        corporate_name: 'Nome Empresa 1 Oficial LTDA',
        brand_name: 'Empresa 1',
        registration_number: '10',
        full_address: 'Rua das Empresas, 1',
        city: 'Empresarial',
        state: 'EM',
        email: 'empresa1@empresas.com'
      )
      product_1 = ProductModel.create!(
        name: 'Produto A',
        weight: 10,
        width: 11,
        height: 12,
        depth: 13,
        sku: '101010',
        supplier: supplier_x
      )
      product_2 = ProductModel.create!(
        name: 'Produto B',
        weight: 20,
        width: 21,
        height: 22,
        depth: 23,
        sku: '202020',
        supplier: supplier_x
      )
      #Act
      visit root_path
      within('nav') do
        click_on 'Modelos de Produtos'
      end

      #Assert
        #garantir que aparece
      expect(page).to have_content product_1.name
      expect(page).to have_content product_1.sku
      expect(page).to have_content product_1.supplier.brand_name
      expect(page).to have_content product_2.name
      expect(page).to have_content product_2.sku
      expect(page).to have_content product_2.supplier.brand_name
    end

    it 'e não existem produtos cadastrados ' do
      #Arrange
      user = User.create!(name: "Fulane", email: "fu@lane.com", password: "pass1w0rd")
      login_as(user)
      #Act
      visit root_path
      within('nav') do
        click_on 'Modelos de Produtos'
      end
      #Assert
      expect(page).to have_content 'Não existem modelos de produtos cadastrados!'
    end
end
