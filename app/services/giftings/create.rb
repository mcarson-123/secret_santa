module Giftings
  class Create

    def initialize(party_id)
      @party = Party.find(party_id)
    end

    def create
      generate_linkings
      send_emails
    end

    private

    def send_emails
      @party.giftings.each do |gifting|
        GiftingMailer.new_gifting(gifting).deliver_later
      end
    end

    def generate_linkings
      participants = @party.participants
      shuffled_participants = shuffle_participants
      participants.length.times do |i|
        Gifting.create(participant: participants[i],
                       giftee: shuffled_participants[i])
      end
    end

    # For each item: if its not the first, swap with random lesser element
    def shuffle_participants
      participants = @party.participants
      shuffled_participants = participants.to_a
      participants.length.times do |i|
        next if i == 0
        random_lesser_index = Random.rand(i)
        swap_item = shuffled_participants[random_lesser_index]
        shuffled_participants[random_lesser_index] = shuffled_participants[i]
        shuffled_participants[i] = swap_item
      end
      shuffled_participants
    end

  end
end
