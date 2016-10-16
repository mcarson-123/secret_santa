class PartiesController < ApplicationController
  before_action :find_party, only: [:show, :create_giftings]

  def show
    @participants = @party.participants
    @participant = Participant.new
  end

  def new
    @party = Party.new
  end

  def create
    party = Party.create(party_params)
    redirect_to "/parties/#{party.encoded_id}"
  end

  def create_giftings
    Giftings::Create.new(@party.id).create
    redirect_to "/participants/success"
  end

  private

  def party_params
    params.require(:party).permit(:theme, :name, :spending_limit, gift_options: [])
  end

  def find_party
    @party = Party.obj_from_encoded_id(params[:id])
  end

end
