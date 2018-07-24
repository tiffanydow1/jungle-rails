require 'rails_helper'

#  RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe User, type: :model do

  describe 'Validations' do

    before :each do
      @invalid_user = User.new
    end

    it 'Create a new user' do
      user = User.new(name: 'Tiffany Dow', email: 'tiffanyjdow@gmail.com', password: 'test1234', password_confirmation: 'test1234')
      expect(user).to be_valid
    end

    it 'Must have a password' do
      user = User.new(name: 'Tiffany Dow', email: 'tiffanyjdow@gmail.com', password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to eql ["can't be blank", "can't be blank", "is too short (minimum is 5 characters)"]
    end

    it 'Must have password confirmation' do
      user = User.new(name: 'Tiffany Dow', email: 'tiffanyjdow@gmail.com', password: 'test1234', password_confirmation: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to eql ["can't be blank"]
    end

    it 'Password and Password Confirmation should match' do
      user = User.new(name: 'Tiffany Dow', email: 'tiffanyjdow@gmail.com', password: 'test1234', password_confirmation: 'test4321')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to eql ["doesn't match Password"]
    end

    it 'Must have full name' do
      user = User.new(name: nil, email: 'tiffanyjdow@gmail.com', password: 'test1234', password_confirmation: 'test1234')
      expect(user).not_to be_valid
      expect(user.errors[:name]).to eql ["can't be blank"]
    end

    it 'User must enter an email' do
      user = User.new(name: 'Tiffany Dow', email: nil, password: 'test1234', password_confirmation: 'test1234')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to eql ["can't be blank"]
    end

    it 'email must be unique' do
      user = User.new(email: 'tiffanyjdow@gmail.com', password: 'test1234', password_confirmation: 'test1234')
      user.save

      user2 = User.new(email: 'tiffanyjdow@gmail.com', password: '12345', password_confirmation: '12345')
      user2.save

      expect(user2.errors.get(:email)).to eql(nil)
    end

    it 'password length less than 5 characters is invalid' do
      user = User.new(email: 'tiffanyjdow@gmail.com', password: 'test', password_confirmation: 'test')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to eql ["is too short (minimum is 5 characters)"]
    end
  end
end


describe '.authenticate_with_credentials' do

  it 'User authenticated when email includes spaces' do
    user = User.new(email: '   tiffanyjdow@gmail.com', password: 'test1234', password_confirmation: 'test1234')
    expect(User.authenticate_with_credentials(email, password)).to eql user
  end

  it 'User email is not case-sensitive' do
    user = User.new(email: 'TIFFANYjDOW@gmail.com', password: 'test1234', password_confirmation: 'test1234')
    expect(User.authenticate_with_credentials(email, password)).to eql user
  end

  it 'User authenticated when email and password match database' do
    user = User.new(email: 'tiffanyjdow@gmail.com', password: 'Jeesanlee17', password_confirmation: 'Jeesanlee17')
    expect(User.authenticate_with_credentials(email, password)).to eql user
  end

end






   #    it "fails when email does not math db email" do
   #  User.create!(first_name: "Mere", last_name: "Mumby", email: "TEST1@TEST.com", password: "password", password_confirmation: "password")
   #  email = "cash@gmail.com"
   #  password = "password"
   #  expect(User.authenticate_with_credentials(email, password)).to eql false
   # end


   #  it "fails when password does not math db password" do
   #  User.create!(first_name: "Mere", last_name: "Mumby", email: "TEST1@TEST.com", password: "password", password_confirmation: "password")
   #  email = "TEST1@TEST.com"
   #  password = "pswdd"
   #  expect(User.authenticate_with_credentials(email, password)).to eql false
   # end



  #end


