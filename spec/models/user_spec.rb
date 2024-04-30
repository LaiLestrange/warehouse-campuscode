require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#description" do
    it "exibe o nome e o email" do
      #arrange
      u = User.new(name: 'Cliente', email: "outro@cliente.com")
      #act
      result = u.description
      #assert
      expect(result).to eq 'Cliente - outro@cliente.com'
    end
  end

end
