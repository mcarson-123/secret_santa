class GiftingsController < ApplicationController
  before_action :find_gifting, only: [:remind]

  def confirm
    gifting = Gifting.find_by(confirm_token: params[:confirm_token])
    gifting.confirmed!
    redirect_to "/participants/#{gifting.participant.encoded_id}/edit"
  end

  def remind
    GiftingMailer.remind(@gifting).deliver_later
    participant = @gifting.participant
    flash[:notice] = %(Gifting email resent to #{participant.name})
    redirect_to "/parties/#{participant.party.encoded_id}"
  end

  private

  def find_gifting
    @gifting = Gifting.obj_from_encoded_id(params[:id])
  end

end
