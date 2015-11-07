# Preview all emails at http://localhost:3000/rails/mailers/gifting_mailer
class GiftingMailerPreview < ActionMailer::Preview

  def new_gifting
    gifting = Gifting.first
    p "***GIFTING", gifting
    GiftingMailer.new_gifting(gifting)
  end

end
