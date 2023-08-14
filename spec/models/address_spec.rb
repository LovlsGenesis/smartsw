require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:user) do
    User.create(name: 'test', email: 'test@test.com', password: 'test')
  end

  let(:address) do
    Address.new(cep: '11111111',
                district: 'SP',
                city: 'São Paulo',
                neighborhood: 'Paulista',
                address: 'Paulista',
                user_id: user.id)
  end

  it 'should be valid' do
    expect(address).to be_valid
    expect(address.cep).to eq('11111111')
    expect(address.address).to eq('Paulista')
    expect(address.neighborhood).to eq('Paulista')
    expect(address.city).to eq('São Paulo')
    expect(address.district).to eq('SP')
  end

  it 'should create an Address with the test method' do
    address = Address.find_cep_and_create('01311100', user.id)

    expect(address).to be_valid
    expect(address.cep).to eq('01311100')
    expect(address.address).to eq('Avenida Paulista - de 611 a 1045 - lado ímpar')
    expect(address.neighborhood).to eq('Bela Vista')
    expect(address.city).to eq('São Paulo')
    expect(address.district).to eq('SP')
  end

  describe 'Errors' do
    it 'should be invalid if user is nil' do
      address.user_id = nil

      expect(address).to_not be_valid
    end

    it 'should be invalid if cep is nil' do
      address.cep = nil

      expect(address).to_not be_valid
    end

    it 'should be invalid if address is nil' do
      address.address = nil

      expect(address).to_not be_valid
    end

    it 'should be invalid if neighborhood is nil' do
      address.neighborhood = nil

      expect(address).to_not be_valid
    end

    it 'should be invalid if city is nil' do
      address.city = nil

      expect(address).to_not be_valid
    end

    it 'should be invalid if district is nil' do
      address.district = nil

      expect(address).to_not be_valid
    end

    it 'should return an error message if cep is not found' do
      expect { Address.find_cep_and_create('fakecep', user.id) }.to raise_error('CEP not found')
    end
  end
end
