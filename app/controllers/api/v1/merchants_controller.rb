class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    name = Merchant.search_by_name(merchant_params[:name]).first
    if name.present?
      render json: MerchantSerializer.new(name)
    else
      render json: MerchantSerializer.new(name)
    end
  end

  private

  def merchant_params
    params.permit(:id, :name)
  end

end