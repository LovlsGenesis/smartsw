require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) do
    User.create!({
                   name: 'Guillaume',
                   email: 'g.zeldine@gmail.com',
                   password: '123456'
                 })
  end

  let(:valid_attributes) do
    {
      cep: '01311100'
    }
  end

  let(:invalid_attributes) do
    {
      cep: 'fakecep'
    }
  end

  describe 'GET #find' do
    it 'return CEP infos' do
      user.generate_token(user.password)
      request.headers.merge({ Authorization: "Bearer #{user.token}" })
      get :find, params: valid_attributes

      expect(response).to be_successful
      expect(body['cep']).to eq(valid_attributes[:cep])
      expect(body['address']).to eq('Avenida Paulista - de 611 a 1045 - lado ímpar')
      expect(body['neighborhood']).to eq('Bela Vista')
      expect(body['city']).to eq('São Paulo')
      expect(body['district']).to eq('SP')
    end

    it 'should save the user that performed the request' do
      user.generate_token(user.password)
      request.headers.merge({ Authorization: "Bearer #{user.token}" })
      get :find, params: valid_attributes

      address = Address.last

      expect(response).to be_successful
      expect(address.user).to eq(user)
    end

    describe 'Bad Request' do
      it 'should return an error with an inexistant CEP' do
        user.generate_token(user.password)
        request.headers.merge({ Authorization: "Bearer #{user.token}" })
        get :find, params: invalid_attributes
        expect(response.status).to eq(404)
        expect(body['message']).to eq('CEP not found')
      end

      it 'should return an error with an invalid token' do
        request.headers.merge({ Authorization: 'Bearer FakeToken' })
        get :find, params: invalid_attributes
        expect(response.status).to eq(400)
        expect(body['message']).to eq('Invalid token')
      end

      it 'should return an error with an expired token' do
        user.generate_token(user.password)
        user.token_expiration_date = Time.now - 1.hour
        user.save
        request.headers.merge({ Authorization: "Bearer #{user.token}" })
        get :find, params: invalid_attributes

        expect(response.status).to eq(400)
        expect(body['message']).to eq('Expired token, please refresh it')
      end
    end
  end
end
