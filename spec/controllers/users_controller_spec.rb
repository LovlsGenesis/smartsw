require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Guillaume',
      email: 'g.zeldine@gmail.com',
      password: '123456'
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      email: 'g.zeldine@gmail.com',
      password: ''
    }
  end

  let(:update_attributes) do
    {
      name: 'Guillaume Update',
      email: 'update@gmail.com',
      password: 'update'
    }
  end

  describe 'GET #index' do
    it 'returns all users' do
      get :index, params: {}

      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a user' do
      User.create!(valid_attributes)
      get :show, params: { id: User.first.id }

      expect(response).to be_successful
      expect(body).to eq(JSON.parse(User.first.attributes.to_json))
    end

    it 'should return a bad request with an inexistant user' do
      get :show, params: { id: 'FakeId' }

      expect(response.status).to eq(404)
      expect(body['message']).to eq('User not found')
    end
  end

  describe 'POST #create' do
    it 'should create a new user' do
      post :create, params: { user: valid_attributes }

      expect(response).to be_successful
      expect(body['email']).to eq(valid_attributes[:email])
      expect(body['name']).to eq(valid_attributes[:name])
    end

    it 'should return a bad request with invalid attributes' do
      post :create, params: { id: 'FakeId', user: invalid_attributes }

      expect(response.status).to eq(400)
      expect(body['message']).to eq('Error creating user')
    end
  end

  describe 'PATCH #update' do
    it 'should update a user attributes' do
      user = User.create!(valid_attributes)
      put :update, params: { id: user.id, user: update_attributes }

      user.reload
      expect(response).to be_successful
      expect(body['email']).to eq(update_attributes[:email])
      expect(body['name']).to eq(update_attributes[:name])
    end

    it 'should return a bad request with an inexistant user' do
      put :update, params: { id: 'FakeId', user: update_attributes }

      expect(response.status).to eq(404)
      expect(body['message']).to eq('User not found')
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete a user' do
      user = User.create!(valid_attributes)

      delete :destroy, params: { id: user.id }

      expect(response).to be_successful
    end
  end
end
