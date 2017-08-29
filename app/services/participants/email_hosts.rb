module Participants
  class EmailHosts

    def initialize(party)
      @party = party
    end

    # new_passphrase generates a new passphrase to be used
    # to access existing parties.
    # Useful if hosts are removed from the party and want
    # to revoke their access.
    def call(new_passphrase: true)
      update_party_passphrase if new_passphrase

      @party.hosts.each do |host|
        ParticipantsMailer.notify_host(host).deliver_later
      end
    end

    private

    def update_party_passphrase
      @party.generate_passphrase
      @party.save
    end

  end
end
