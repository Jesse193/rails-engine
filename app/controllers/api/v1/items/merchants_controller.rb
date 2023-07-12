class Api::V1::Items::MerchantsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.find(params[:item_id]))
  end
end