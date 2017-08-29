class ParticipantsController < ApplicationController
  before_action :find_participant, only: [:edit, :update, :update_preferences]

  def create
    @participant = Participant.create(participants_params)

    redirect_to "/parties/#{@participant.party.encoded_id}"
  end

  def edit
  end

  def update
    Participants::Update.new(@participant).call(update_params)
    unless @participant.previous_changes[:email].blank?
      flash[:notice] = %(Gifting email resent to
                         #{@participant.name_with_possessive_suffix} new email)
    end
    redirect_to "/parties/#{@participant.party.encoded_id}"
  end

  def update_preferences
    @participant.update(gift_preferences: Array.wrap(update_preferences_params[:gift_preferences]))
    GiftingMailer.share_preferences(Gifting.find_by(giftee: @participant)).deliver_later
    redirect_to "/participants/success"
  end

  def success
  end

  private

  def participants_params
    params.require(:participant).permit(:email, :name, :party_id, :party_owner)
  end

  def update_preferences_params
    params.require(:participant).permit(:gift_preferences)
  end

  def update_params
    params.require(:participant).permit(:email, :name)
  end

  def find_participant
    @participant = Participant.obj_from_encoded_id(params[:id])
  end
end
