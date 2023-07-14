class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_response
  rescue_from ActiveRecord::RecordInvalid, with: :no_parameter

  def error_response(error)
    render json: ErrorSerializer.new(error).serialize_json, status: 404
  end

  def no_parameter(error)
    render json: ErrorSerializer.new(error).no_name, status: 400
  end

  before_action :beforeFilter, :only => [:search]  

  def beforeFilter
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
end
