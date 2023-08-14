require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(name: 'John', email: 'test@test.com', password: 'testpassword')
  end

  let(:created_user) do
    User.create!(name: 'John', email: 'test@test.com', password: 'testpassword')
  end

  it 'should be valid' do
    expect(user).to be_valid
  end

  it 'should create the user password_digest' do
    expect(user).to be_valid
    expect(user.password_digest).to_not be_empty
  end

  it "should generate a user's token" do
    user.generate_token(user.password)

    expect(user).to be_valid
    expect(user.token).to_not be_empty
    expect(user.refresh_token).to_not be_empty
    expect(user.token_expiration_date.to_date.class).to eq(Date)
  end

  describe 'Errors' do
    it 'should be invalid if email is nil' do
      user.email = nil

      expect(user).to_not be_valid
    end

    it 'should be invalid if password is nil' do
      user.password = nil

      expect(user).to_not be_valid
    end

    it 'should be invalid if email is not unique' do
      user.save
      new_user = User.new(name: 'whatever', email: 'test@test.com', password: 'testpassword')

      expect(new_user).to_not be_valid
    end
  end
end
