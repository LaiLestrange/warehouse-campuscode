require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe "#valid?" do
    context "presence" do
      it "name is mandatory" do
        supplier = Supplier.create!(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: 'Empresa 1',
          registration_number: '10',
          full_address: 'Rua das Empresas, 1',
          city: 'Empresarial',
          state: 'EM',
          email: 'empresa1@empresas.com'
        )
        pm = ProductModel.new(
          name: '',
          weight: 10,
          width: 11,
          height: 12,
          depth: 13,
          sku: '101010',
          supplier: supplier
        )
        expect(pm.valid?).to eq false

      end
      it "sku is mandatory" do
        supplier = Supplier.create!(
          corporate_name: 'Nome Empresa 1 Oficial LTDA',
          brand_name: 'Empresa 1',
          registration_number: '10',
          full_address: 'Rua das Empresas, 1',
          city: 'Empresarial',
          state: 'EM',
          email: 'empresa1@empresas.com'
        )
        pm = ProductModel.new(
          name: 'Produto A',
          weight: 10,
          width: 11,
          height: 12,
          depth: 13,
          sku: '',
          supplier: supplier
        )
        expect(pm.valid?).to eq false

      end
    end
  end

end
