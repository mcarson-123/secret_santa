module Obfuscate
  extend ActiveSupport::Concern

  # Note this is in no way an encrypted id, I know this will be easy to crack
  # but it's good enough for the purposes of this app, and gives the benefits
  # I really care about, which are short and readable ids.

  extend self

  def encode(id)
    id_bytes = [id].pack("N")
    ZBase32.encode(id_bytes)
  end

  def decode(encoded)
    decoded_bytes = ZBase32.decode(encoded)
    # result of unpack is a single element array
    decoded_bytes.unpack("N").first
  end
end
