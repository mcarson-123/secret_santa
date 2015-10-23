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
    update_params[:gift_preferences] = Array.wrap(update_params[:gift_preferences])
    @participant.update(update_params)
    redirect_to "/participants/success"
  end

  def success
  end

  private

  def participants_params
    params.require(:participant).permit(:email, :party_id)
  end

  def update_params
    params.require(:participant).permit(:gift_preferences)
  end
end
