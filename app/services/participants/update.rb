module Participants
  class Update

    def initialize(participant)
      @participant = participant
    end

    def call(params)
      @participant.update(params)
      unless @participant.previous_changes[:email].blank?
        p "*** NEW EMAIL"
        GiftingMailer.new_gifting(@participant.gifting).deliver_later
      end
    end
  end
end
