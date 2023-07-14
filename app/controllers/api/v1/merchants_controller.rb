class Api::V1::MerchantsController < ApplicationController
  skip_before_action :find_filter

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    name = Merchant.search_by_name(merchant_params[:name])
    if !params[:name].empty?
      render json: MerchantSerializer.new(name)
    else
      raise ActiveRecord::RecordInvalid
    end
  end

  private
  def merchant_params
    params.permit(:id, :name)
  end
end