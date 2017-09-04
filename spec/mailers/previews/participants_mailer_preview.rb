# Preview all emails at http://localhost:3000/rails/mailers/participants_mailer
class ParticipantsMailerPreview < ActionMailer::Preview

  def notify_host
    party = Party.first
    host = party.hosts.first
    ParticipantsMailer.notify_host(host)
  end

end
