class ErrorSerializer
  def initialize(error)
    @error = error
  end
  
  def serialize_json
    {errors: [{status: "404", title: @error.message}]}
  end

  def no_name
    {errors: [{status: "400", title: @error.message}]}
  end
end