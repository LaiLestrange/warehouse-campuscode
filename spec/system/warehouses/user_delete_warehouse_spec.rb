require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    #Arrange
    Warehouse.create!(name: 'Aero SSA', code:  'EVA', city: 'Salvador', area:210_000,
    address: 'Estrada Velha do Aeroporto, 5', cep: '17000-000',
    description: 'Galpão da última astronave')

    #Act
    visit root_path
    click_on 'Aero SSA'
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content("Galpão removido com sucesso")
    expect(page).not_to have_content("Aero SSA")
    expect(page).not_to have_content("Código: EVA")

  end

  it 'e não apaga outros galpões' do
    #Arrange
    Warehouse.create!(name: 'Aero SSA', code:  'EVA', city: 'Salvador', area:210_000,
    address: 'Estrada Velha do Aeroporto, 5', cep: '17000-000',
    description: 'Galpão da última astronave') #w1
    Warehouse.create!(name: 'Aero VCA', code:  'VDC', city: 'Vitória da Conquista', area:217_000,
    address: 'Estrada da Suiça Baiana, 77', cep: '77000-000',
    description: 'Galpão da boca do inferno') #w2


    #Act
    visit root_path
    click_on 'Aero VCA'
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content "Galpão removido com sucesso"
    expect(page).not_to have_content "Aero VCA"
    expect(page).not_to have_content "Código: VDC"
    expect(page).to have_content "Aero SSA"
    expect(page).to have_content "Código: EVA"

  end
end
