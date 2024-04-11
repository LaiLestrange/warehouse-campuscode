require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        warehouse = Warehouse.new(
          name: '',
          code: 'COD',
          city: 'Cidade',
          area: '100000',
          address: 'Endereço, 1',
          cep: '10000-000',
          description: 'Descrição'
          )

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when code is empty' do
        #Arrange
        warehouse = Warehouse.new(
          name: 'Nome',
          code: '',
          city: 'Cidade',
          area: '100000',
          address: 'Endereço, 1',
          cep: '10000-000',
          description: 'Descrição'
          )

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when city is empty' do
        #Arrange
        warehouse = Warehouse.new(
          name: 'Nome',
          code: 'COD',
          city: '',
          area: '100000',
          address: 'Endereço, 1',
          cep: '10000-000',
          description: 'Descrição'
          )

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when area is empty' do
        #Arrange
        warehouse = Warehouse.new(
          name: 'Nome',
          code: 'COD',
          city: 'Cidade',
          area: '',
          address: 'Endereço, 1',
          cep: '10000-000',
          description: 'Descrição'
          )

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when address is empty' do
        #Arrange
        warehouse = Warehouse.new(
          name: 'Nome',
          code: 'COD',
          city: 'Cidade',
          area: '100000',
          address: '',
          cep: '10000-000',
          description: 'Descrição'
          )

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when cep is empty' do
        #Arrange
        warehouse = Warehouse.new(
          name: 'Nome',
          code: 'COD',
          city: 'Cidade',
          area: '100000',
          address: 'Endereço, 1',
          cep: '',
          description: 'Descrição'
          )

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when description is empty' do
        #Arrange
        warehouse = Warehouse.new(
          name: 'Nome',
          code: 'COD',
          city: 'Cidade',
          area: '100000',
          address: 'Endereço, 1',
          cep: '10000-000',
          description: ''
          )

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
      end
    end

    context 'length' do
      it 'false when code is more than 3 characters' do
        #Arrange
        warehouse = Warehouse.new(
          name: 'Nome',
          code: 'CODI',
          city: 'Cidade',
          area: '100000',
          address: 'Endereço, 1',
          cep: '10000-000',
          description: 'Descrição'
          )

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
      end
    end

    context 'uniqueness' do
      it 'false when code is already in use' do
        #Arrange
        first_warehouse = Warehouse.new(
          name: 'Nome 1',
          code: 'COD',
          city: 'Cidade 1',
          area: '100000',
          address: 'Endereço, 1',
          cep: '10000-000',
          description: 'Descrição'
          )
        first_warehouse.save()
        second_warehouse = Warehouse.new(
          name: 'Nome 2',
          code: 'COD',
          city: 'Cidade 2',
          area: '200000',
          address: 'Endereço, 2',
          cep: '20000-000',
          description: 'Descrição 2'
          )

        #Act
        result = second_warehouse.valid?

        #Assert
        expect(result).to eq false

      end
    end
  end
end
