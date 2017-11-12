module Giftings
  class CreateForFamilies

    def initialize(party)
      @party = party
    end

    def call
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
      attempt = 0
      while shuffled_participants.nil? do
        # TODO: catch this error from too many attempts
        break if attempt > 30
        shuffled_participants = shuffle_participants
        attempt += 1
      end

      participants.length.times do |i|
        Gifting.create(participant: participants[i],
                       giftee: shuffled_participants[i])
      end
    end

    # For each item: if its not the first, swap with random lesser element
    def shuffle_participants
      # participants = @party.participants
      # shuffled_participants = participants.to_a
      # participants.length.times do |i|
      #   next if i == 0
      #   random_lesser_index = Random.rand(i)
      #   swap_item = shuffled_participants[random_lesser_index]
      #   shuffled_participants[random_lesser_index] = shuffled_participants[i]
      #   shuffled_participants[i] = swap_item
      # end
      # shuffled_participants

      participants = @party.participants
      guest_list = participants.to_a
      shuffled_array = []
      participants.each do |participant|
        available_pairings = guest_list & @party.party_guests_not_in_family(participant)
        return nil if available_pairings.empty?
        pairing = available_pairings.sample
        shuffled_array.push(pairing)
        guest_list.delete(pairing)

        # for each participant
        # add item to shuffled aray that is
        # guest not yet added to shuffled array
        # that is not in their family

        # 1. list of guest list guests not in family
        # 2. add random person in list above to shuffled array
        # if there is no one valid left nil
        # 3. remove random person from remaining guest list

        # N. if there is no one to add, start again
      end
      shuffled_array
    end

  end
end
