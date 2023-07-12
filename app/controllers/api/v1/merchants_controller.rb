class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    name = Merchant.where(name == params[:name])
    render json: MerchantSerializer.new(name)
  end
end