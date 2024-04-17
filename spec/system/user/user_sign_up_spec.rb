require 'rails_helper'

describe "Usuário se autentica" do
    it "com sucesso" do
      #Arrange

      #Act
      visit root_path
      click_on 'Entrar'
      click_on 'Criar uma conta'
      fill_in 'Nome', with: 'Fulane'
      fill_in 'E-mail', with: 'abc@def.ghi'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar Conta'

      #Assert
      expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
      expect(page).to have_content 'Olá, Fulane!'
      expect(page).to have_content 'abc@def.ghi'
      expect(page).to have_button 'Sair'
      user = User.last
      expect(user.name).to eq 'Fulane'

    end
end
