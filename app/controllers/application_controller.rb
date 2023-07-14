class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_response
  rescue_from ActiveRecord::RecordInvalid, with: :no_parameter

  def error_response(error)
    render json: ErrorSerializer.new(error).serialize_json, status: 404
  end

  def no_parameter(error)
    render json: ErrorSerializer.new(error).no_name, status: 400
  end
end
