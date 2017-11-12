class FamiliesController < ApplicationController
  before_action :find_family, only: [:edit]

  def new
    # @party = Party.last
    # respond_to do |format|
    #   format.js {render layout: false}
    # end

  end

  def create
    # family_params = params[:family]
    p "PARAMS", family_params

    # TODO: wrap in transaction
    family = Family.create(name: family_params[:name])
    family_params[:participant_ids].each do |participant_id|
      participant = Participant.find_by(id: participant_id)
      next unless participant
      participant.update(family_id: family.id)
    end

    party_id = params[:party][:encoded_id]
    redirect_to "/parties/#{party_id}/group_families"
  end

  def edit
  end

  private

  def family_params
    params.require(:family).permit(:name, participant_ids: [])
  end

  def find_party
    @party = Party.obj_from_encoded_id(params[:party_id])
  end

  def find_family
    @family = Family.find(params[:id])
  end

end
