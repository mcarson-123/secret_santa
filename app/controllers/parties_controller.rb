class PartiesController < ApplicationController
  before_action :find_party, only: [:show, :create_giftings]

  def show
    @participants = @party.participants
    @participant = Participant.new
  end

  def find
    parties = Party
                .where(passphrase: params[:existing_party][:holiday_passphrase])
                .joins(:participants)
                .where("email = ? AND party_owner = true", params[:existing_party][:email])

    if parties.empty?
      flash[:error] = "no_parties_found"
      redirect_to "/" and return
    end

    if parties.size == 1
      redirect_to "/parties/#{parties.first.encoded_id}" and return
    else
      @parties = parties # Ask user to choose which of their parties to view
    end
  end

  def new
    @party = Party.new
  end

  def create
    party = Party.create(party_params)
    redirect_to "/parties/#{party.encoded_id}"
  end

  def create_giftings
    Giftings::Create.new(@party).call
    # TODO: run in job
    Participants::EmailHosts.new(@party).call
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
