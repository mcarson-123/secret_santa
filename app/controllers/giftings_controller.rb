class GiftingsController < ApplicationController

  def confirm
    gifting = Gifting.find_by(confirm_token: params[:confirm_token])
    gifting.confirmed!
    redirect_to "/participants/#{gifting.participant.encoded_id}/edit"
  end

end
