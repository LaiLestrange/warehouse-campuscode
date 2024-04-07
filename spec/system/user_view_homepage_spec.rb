require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da app' do
    # Arrange
      #pré-requisitos para a aplicação
      #o que nesse caso não é necessário

    # Act
    visit('/')

    # Assert
    expect(page). to have_content('Galpões & Estoque')
  end
end
