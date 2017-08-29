class ParticipantsMailer < ApplicationMailer
  add_template_helper(ConfirmationHelper)

  def notify_host(host)
    @host = host
    mail(to: @host.email, subject: "Secret Santa")
  end
end
