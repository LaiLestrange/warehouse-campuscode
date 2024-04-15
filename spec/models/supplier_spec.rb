require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe "#valid?" do
    context "presence" do
      it "false when corporate_name is empty" do
        supplier = Supplier.new(
          corporate_name: ' ',
          brand_name: 'Empresa 1',
          registration_number: '10',
          full_address: 'Rua das Empresas, 1',
          city: 'Empresarial',
          state: 'EM',
          email: 'empresa1@empresas.com'
        )
        expect(supplier.valid?).to eq false
      end
      it "false when brand_name is empty" do
        supplier = Supplier.new(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: ' ',
          registration_number: '10',
          full_address: 'Rua das Empresas, 1',
          city: 'Empresarial',
          state: 'EM',
          email: 'empresa1@empresas.com'
        )

        expect(supplier.valid?).to eq false
      end
      it "false when registration_number is empty" do
        supplier = Supplier.new(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: 'Empresa 1',
          registration_number: ' ',
          full_address: 'Rua das Empresas, 1',
          city: 'Empresarial',
          state: 'EM',
          email: 'empresa1@empresas.com'
        )

        expect(supplier.valid?).to eq false
      end
      it "false when full_address is empty" do
        supplier = Supplier.new(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: 'Empresa 1',
          registration_number: '10',
          full_address: ' ',
          city: 'Empresarial',
          state: 'EM',
          email: 'empresa1@empresas.com'
        )

        expect(supplier.valid?).to eq false
      end
      it "false when city is empty" do
        supplier = Supplier.new(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: 'Empresa 1',
          registration_number: '10',
          full_address: 'Rua das Empresas, 1',
          city: ' ',
          state: 'EM',
          email: 'empresa1@empresas.com'
        )

        expect(supplier.valid?).to eq false
      end
      it "false when state is empty" do
        supplier = Supplier.new(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: 'Empresa 1',
          registration_number: '10',
          full_address: 'Rua das Empresas, 1',
          city: 'Empresarial',
          state: ' ',
          email: 'empresa1@empresas.com'
        )

        expect(supplier.valid?).to eq false
      end
      it "false when email is empty" do
        supplier = Supplier.new(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: 'Empresa 1',
          registration_number: '10',
          full_address: 'Rua das Empresas, 1',
          city: 'Empresarial',
          state: 'EM',
          email: ' '
        )
        expect(supplier.valid?).to eq false
      end
    end

    context "length" do
      it 'false when state is more than 2 characters' do
        supplier = Supplier.new(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: 'Empresa 1',
          registration_number: '10',
          full_address: 'Rua das Empresas, 1',
          city: 'Empresarial',
          state: 'EMP',
          email: 'empresa1@empresas.com'
        )

        expect(supplier.valid?).to eq false
      end

    end

    context "uniequeness" do
      it 'false when registration_number is already in use' do
        s1 = Supplier.new(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: 'Empresa 1',
          registration_number: '10',
          full_address: 'Rua das Empresas, 1',
          city: 'Empresarial',
          state: 'EM',
          email: 'empresa1@empresas.com'
        )
        s1.save()

        s2 = Supplier.new(
          corporate_name: 'Nome Empresa 2 Oficial LTDA',
          brand_name: 'Empresa 2',
          registration_number: '10',
          full_address: 'Rua das Empresas, 2',
          city: 'Empresarial',
          state: 'EM',
          email: 'empresa2@empresas.com'
        )

        expect(s2.valid?).to eq false
      end

    end


  end

end
