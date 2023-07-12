class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    if params[:search].present?
      render json: MerchantSerializer.new(Merchant.find(merchant_params))
    else
      flash[:alert] = "error no merchant found"
    end
  end
end