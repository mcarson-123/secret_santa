class PartiesController < ApplicationController

  def show
    @party = Party.find(params[:id])
    @participants = @party.participants
    @participant = Participant.new
  end

  def new
    @party = Party.new
  end

  def create
    p "PARTY PARAMS", party_params
    party = Party.create(party_params)
    redirect_to "/parties/#{party.id}"
  end

  def create_giftings #create_giftings_party_path(@party)
    p "creating giftings"
    Giftings::Create.new(params[:id]).create
    redirect_to "/participants/success"
  end

  private

  def party_params
    params.require(:party).permit(:theme, :name, :spending_limit, gift_options: [])
  end

end
