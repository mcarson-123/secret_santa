module Giftings
  class CreateForFamilies
    # TODO: put error handling in the controller and move this functionality
    # to the Giftings::Create?

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

    # [a0, a1, a2, b0, b1, b2, c0, c1]
    # [a0, a1, a2, b0, b1, b2, c0, c1]

    # [b0, b1, b2, c0, c1, a0, a1, a2]
    # [c0, b1, b2, b0, c1, a0, a1, a2]
    # [c0, c1, b2, b0, b1, a0, a1, a2]
    # [c0, c1, a0, b0, b1, b2, a1, a2]
    # [c0, c1, a0, b0, b1, b2, a1, a2]
    # 1. Order by largest family first, then ascending family size
    #    (This ensures that if there are two families of equal largest size
    #     they dont swap equally and the remaining family isn't able to swap
    #     outside their family)
    # 2. skip first family
    # 3. with each family, swap with first participant (starting from beginning)
    #    that hasn't been swapped yet.
    #    If all participants have been swapped, can take random participant
    #    from previous family (have to check it's not in own family)
    # 4. Shuffle shuffled array by family

    # This function will create an array the same size as the participants array
    # The first element in the shuffled array will represent the person that
    # participant is to buy for.
    def shuffle_participants
      guest_list = sorted_guest_list

      first_family_size = guest_list.first.family.size
      # Make array to keep track of the shuffled list
      shuffled_guest_list = guest_list.to_a
      last_index_of_previous_family = first_family_size - 1

      guest_list.each_with_index do |guest, i|
        next if i < first_family_size
        # For each family past the first:
        # Grab someone in a previous family at 'random' who hasn't been
        # swapped. Taking someone who hasn't been swapped first ensures
        # that everyone will be swapped.
        # If everyone has been swapped, can take anyone.

        # need list of guests in previous families
        previous_families_guests = guest_list.first(last_index_of_previous_family)
        # take union of this with people who haven't been swapped (unless
        # everyone has been swapped)
        # (if people are in the shuffled array they have been swapped)
        unless (previous_families_guests - shuffled_guest_list).empty?
          previous_families_guests = previous_families_guests - shuffled_array
        end

        # random_lesser_index = Random.rand(i)
        random_participant = previous_families_guests.sample
        random_participant_index = shuffled_guest_list.index_of(random_participant)
        shuffled_guest_list[random_participant_index] = shuffled_guest_list[i]
        shuffled_guest_list[i] = random_participant

        # update last_index_of_previous_family if necessary
        unless guest.family == guest_list[i+1]
          last_index_of_previous_family = i
        end
      end

      shuffled_array
    end

    # Returns participants, grouped by family, in order of largest family
    # first, then the remainder of the families in ascending size order
    # This is used to assist in sorting in one pass of the participant list
    def sorted_guest_list
      families = @party.families
      guest_list = []
      descending_families = families.sort_by { |family| family.size }
      ascending_families = descending_families.reverse
      largest_family = ascending_families.pop
      sorted_family_list = [largest_family] << ascending_families

      guest_list = sorted_family_list.map do |family|
        family.participants
      end

      guest_list.flatten
    end

    # # For each item: if its not the first, swap with random lesser element
    # def shuffle_participants
    #   # participants = @party.participants
    #   # shuffled_participants = participants.to_a
    #   # participants.length.times do |i|
    #   #   next if i == 0
    #   #   random_lesser_index = Random.rand(i)
    #   #   swap_item = shuffled_participants[random_lesser_index]
    #   #   shuffled_participants[random_lesser_index] = shuffled_participants[i]
    #   #   shuffled_participants[i] = swap_item
    #   # end
    #   # shuffled_participants

    #   participants = @party.participants
    #   guest_list = participants.to_a
    #   shuffled_array = []
    #   participants.each do |participant|
    #     available_pairings = guest_list & @party.party_guests_not_in_family(participant)
    #     return nil if available_pairings.empty?
    #     pairing = available_pairings.sample
    #     shuffled_array.push(pairing)
    #     guest_list.delete(pairing)

    #     # for each participant
    #     # add item to shuffled aray that is
    #     # guest not yet added to shuffled array
    #     # that is not in their family

    #     # 1. list of guest list guests not in family
    #     # 2. add random person in list above to shuffled array
    #     # if there is no one valid left nil
    #     # 3. remove random person from remaining guest list

    #     # N. if there is no one to add, start again
    #   end
    #   shuffled_array
    # end

  end
end
