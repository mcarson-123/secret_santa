module ConfirmationHelper

  # Returns confirmation url for given token
  #
  # @param [String] token
  # @return [String]
  def confirmation_url(token)
    root_url(host: Rails.configuration.x.app_host) + "confirm/#{token}"
  end

end
