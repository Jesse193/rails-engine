class Api::V1::Items::MerchantsController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    merchant = item.merchant
    render json: MerchantSerializer.new(merchant)
  end
end