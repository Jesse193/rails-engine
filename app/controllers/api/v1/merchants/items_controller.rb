class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.find(params[:merchant_id]))
  end
end