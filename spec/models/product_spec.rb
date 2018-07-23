require 'rails_helper'

#RSpec.describe ProductSpec, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  RSpec.describe Product, type: :model do

    describe 'Validations' do
      before :each do
        @category = Category.new(name: 'Household Items')
      end

      it 'Create an instance of Product' do
        product = Product.new(name: 'mug', price: 10, quantity: 25, category: @category)
        expect(product).to be_valid
      end

      it 'Product must have a name' do
        product = Product.new(name: nil, price: 10, quantity: 25, category: @category)
        expect(product).not_to be_valid
        expect(product.errors[:name]).to eql ["can't be blank"]
      end

      it 'Product must have a price' do
        product = Product.new(name: 'mug', price: nil, quantity: 25, category: @category)
        expect(product).not_to be_valid
        expect(product.errors[:price]).to eql ["is not a number", "can't be blank"]
      end

      it 'Product must have a quantity' do
        product = Product.new(name: 'mug', price: 10, quantity: nil, category: @category)
        expect(product).not_to be_valid
        expect(product.errors[:quantity]).to eql ["can't be blank"]
      end

      it 'Product must be assigned to a category' do
        product = Product.new(name: 'mug', price: 10, quantity: 25, category: nil)
        expect(product).not_to be_valid
        expect(product.errors[:category]).to eql ["can't be blank"]
      end

    end
  end
#end
