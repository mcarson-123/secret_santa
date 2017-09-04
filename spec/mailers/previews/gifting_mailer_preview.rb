# Preview all emails at http://localhost:3000/rails/mailers/gifting_mailer
class GiftingMailerPreview < ActionMailer::Preview

  def new_gifting
    gifting = Gifting.first
    GiftingMailer.new_gifting(gifting)
  end

end
