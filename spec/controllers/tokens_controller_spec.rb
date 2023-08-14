require 'rails_helper'

RSpec.describe TokensController, type: :controller do
  let(:user) do
    User.create!({
                   name: 'Guillaume',
                   email: 'test@test.com',
                   password: '123456'
                 })
  end

  let(:valid_attributes) do
    { token: { password: user.password, email: user.email } }
  end

  describe 'POST #create' do
    it 'return tokens informations' do
      post :create, params: valid_attributes

      expect(response).to be_successful
      expect(body['token']).to_not be_empty
      expect(body['refresh_token']).to_not be_empty
      expect(body['token_expiration_date']).to_not be_empty
    end

    describe 'Bad Request' do
      it 'should return an error with an inexistant email' do
        post :create, params: { token: { password: user.password, email: 'inexistant@email.com' } }
        expect(response.status).to eq(404)
        expect(body['message']).to eq('User not found')
      end

      it 'should return an error with an invalid password' do
        post :create, params: { token: { password: '', email: user.email } }
        expect(response.status).to eq(400)
        expect(body['message']).to eq("Password can't be blank")
      end
    end
  end

  describe 'POST #refresh' do
    it "should refresh user's tokens" do
      user.generate_token(user.password)

      post :refresh, params: { token: { refresh_token: user.refresh_token } }
      expect(response).to be_successful
      expect(body['token']).to_not be_empty
      expect(body['refresh_token']).to_not be_empty
      expect(body['refresh_token']).to_not eq(user.refresh_token)
      expect(body['token_expiration_date']).to_not be_empty
    end

    describe 'Bad Request' do
      it 'should return an error with an invalid refresh token' do
        user.generate_token(user.password)

        post :refresh, params: { token: { refresh_token: 'fake refresh' } }
        expect(response.status).to eq(404)
        expect(body['message']).to eq('Invalid token')
      end
    end
  end

end
