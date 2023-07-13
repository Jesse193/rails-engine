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
    name = Item.search_by_name(params[:name])
    max_price = Item.search_by_max_price(params[:max_price])
    min_price = Item.search_by_min_price(params[:min_price])
    if params[:min_price].present?
      render json: ItemSerializer.new(min_price)
    elsif params[:max_price].present?
      render json: ItemSerializer.new(max_price)
    elsif name.present?
      render json: ItemSerializer.new(name)
    else
      render json: ItemSerializer.new(name)
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end