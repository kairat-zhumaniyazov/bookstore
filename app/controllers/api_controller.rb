class ApiController < ActionController::API
  respond_to :json

  private

  def respond_not_found(error)
    render json: error.to_s, status: :not_found
  end
end
