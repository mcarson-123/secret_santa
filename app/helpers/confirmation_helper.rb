module ConfirmationHelper

  # Returns confirmation url for given token
  #
  # @param [String] token
  # @return [String]
  def confirmation_url(token)
    root_url(host: Rails.configuration.x.app_host) + "confirm/#{token}"
  end

  # Returns the app root url
  # @return [String] token
  def app_root_url
    root_url(host: Rails.configuration.x.app_host)
  end

end
