class IdentitiesController < ApplicationController
  private

  def identities_params
    params.permit(:provider, :uid)
  end
end
