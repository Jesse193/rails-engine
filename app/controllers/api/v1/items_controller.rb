class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item_to_destroy = Item.last
    render json: ItemSerializer.new(Item.create!(item_params)), status: :created
    item_to_destroy.destroy
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def find
    min_price = Item.search_by_min_price(params[:min_price])
    max_price = Item.search_by_max_price(params[:max_price])
    price_range = Item.price_range(params[:min_price], params[:max_price])
    name = Item.search_by_name(params[:name])
    if request.query_parameters.keys.include?("min_price" && "max_price") && request.query_parameters.keys.count == 2
      render json: ItemSerializer.new(price_range)
    elsif request.query_parameters.include?("min_price") && request.query_parameters.values.min.to_i >= 0 && !request.query_parameters.include?("name")
      render json: ItemSerializer.new(min_price)
    elsif request.query_parameters.include?("max_price") && request.query_parameters.values.min.to_i >= 0 && !request.query_parameters.include?("name")
      render json: ItemSerializer.new(max_price)
    elsif name != nil && request.query_parameters.keys.include?("name") && !request.query_parameters.include?("max_price") && !request.query_parameters.include?("min_price")
      render json: ItemSerializer.new(name)
    elsif name = "" && request.query_parameters.keys.include?("name") && !request.query_parameters.include?("max_price") && !request.query_parameters.include?("min_price")
      render json: {}
    elsif request.query_parameters.keys.include?("name" && "max_price") || request.query_parameters.keys.include?("name" && "min_price")
      raise ActiveRecord::RecordInvalid
    else
      raise ActiveRecord::RecordInvalid
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end