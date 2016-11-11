class GiftingMailer < ApplicationMailer
  add_template_helper(ConfirmationHelper)

  def new_gifting(gifting)
    @gifting = gifting
    @participant = gifting.participant
    mail(to: @participant.email, subject: "Secret Santa")
  end

  def share_preferences(gifting)
    @gifting = gifting
    @participant = gifting.participant
    mail(to: @participant.email, subject: "Secret Santa: Note about the gift")
  end

  def remind(gifting)
    @gifting = gifting
    @participant = gifting.participant
    mail(to: @participant.email, subject: "Secret Santa")
  end
end
