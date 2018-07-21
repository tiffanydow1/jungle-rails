class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    @reviews = Review.all
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new(product: @product)
  end

end
