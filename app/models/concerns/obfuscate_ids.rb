module ObfuscateIds
  extend ActiveSupport::Concern

  def encoded_id
    Obfuscate.encode(self.id)
  end

  module ClassMethods
    def obj_from_encoded_id(encoded_id)
      decoded_id = Obfuscate.decode(encoded_id)
      self.find(decoded_id)
    end
  end

end
