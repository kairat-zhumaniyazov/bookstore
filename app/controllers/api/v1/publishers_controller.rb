class Api::V1::PublishersController < ApiController
  include Api::V1::Concerns::Restfull

  private

  def permited_params
    params.require(:publisher).permit(:name)
  end
end
