class ParticipantsController < ApplicationController
  before_action :find_participant, only: [:edit, :update]

  def create
    @participant = Participant.create(participants_params)

    redirect_to "/parties/#{@participant.party.encoded_id}"
  end

  def edit
  end

  def update
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

  def find_participant
    @participant = Participant.obj_from_encoded_id(params[:id])
  end
end
