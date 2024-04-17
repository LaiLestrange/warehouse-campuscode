def login(usuario)

  visit root_path
  click_on 'Entrar'
  within('form') do
    fill_in 'E-mail', with: usuario.email
    fill_in 'Senha', with: usuario.password
    click_on 'Entrar'
  end

end
