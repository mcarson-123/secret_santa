class GiftingMailer < ApplicationMailer
  add_template_helper(ConfirmationHelper)

  def new_gifting(gifting)
    @gifting = gifting
    @participant = gifting.participant
    mail(to: @participant.email, subject: "Secret Santa")
  end
end
