require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir da tela de fornecedores' do
    #arrange

    #act
    visit suppliers_path
    click_on 'Cadastrar Fornecedor'

    #assert
    expect(page).to have_field('Nome da Empresa')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')

  end

  it 'com sucesso ' do
    #arrange

    #act
    visit suppliers_path
    click_on 'Cadastrar Fornecedor'
    fill_in('Nome da Empresa', with: 'Empresa ABC LTDA')
    fill_in('Nome Fantasia', with: 'ABC')
    fill_in('CNPJ', with: '123000125')
    fill_in('Endereço', with: 'Rua CDEF, 50')
    fill_in('Cidade', with: 'Cidade Tal')
    fill_in('Estado', with: 'DF')
    fill_in('E-mail', with: 'ghi@jklm.nop')
    click_on 'Criar Fornecedor'

    #assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content('Fornecedor cadastrado com sucesso!')
    expect(page).to have_content('ABC')
    expect(page).to have_content('Cidade Tal')
    expect(page).to have_content('DF')
  end

  it 'com dados incompletos' do
    #arrange

    #act
    visit suppliers_path
    click_on 'Cadastrar Fornecedor'
    fill_in('Nome da Empresa', with: '')
    fill_in('Nome Fantasia', with: '')
    click_on 'Criar Fornecedor'

    #assert
    expect(page).to have_content 'Fornecedor não cadastrado!'
    expect(page).to have_content 'Nome da Empresa não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Estado não possui o tamanho esperado (2 caracteres)'
  end
end
