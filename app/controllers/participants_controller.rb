class ParticipantsController < ApplicationController

  def create
    @participant = Participant.create(participants_params)
    redirect_to "/parties/#{@participant.party_id}"
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    @participant.update({ gift_preferences: Array.wrap(update_params[:gift_preferences]) })
    GiftingMailer.share_preferences(Gifting.find_by(giftee: @participant)).deliver_later
    redirect_to "/participants/success"
  end

  def success
  end

  private

  def participants_params
    params.require(:participant).permit(:email, :name, :party_id)
  end

  def update_params
    params.require(:participant).permit(:gift_preferences)
  end
end
