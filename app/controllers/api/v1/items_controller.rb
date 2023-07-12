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
    render json: ItemSerializer.new(Item.update(item_params))
  end

  def find
    name = Item.search_by_name(params[:name])
    if name.present?
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