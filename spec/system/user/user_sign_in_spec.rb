require 'rails_helper'

describe "Usuário se autentica" do
  it "com sucesso" do
    #Arrange
    user = User.create!(email: 'email@defulano.com', password: 'password')

    #Act
    visit root_path
    # within('form') do
    click_on 'Entrar'
    # end
    within('form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'
    end

    #Assert
    expect(page).to have_content('Login efetuado com sucesso.')
    # within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content user.email
    # end
  end

  it 'e faz logout' do
    #Arrange
    user = User.create!(email: 'email@defulano.com', password: 'password')

    #Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'
    end
    click_on 'Sair'

    #Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content user.email

  end

end
