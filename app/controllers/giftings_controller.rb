class GiftingsController < ApplicationController

  def confirm
    gifting = Gifting.find_by(confirm_token: params[:confirm_token])
    gifting.confirmed!
    redirect_to "/participants/#{gifting.confirm_token}/edit"
  end

end
