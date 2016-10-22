module HolidayPassphrase
  extend ActiveSupport::Concern

  module ClassMethods

    def holiday_passphrase(attr_name)
      define_method "generate_#{attr_name}" do
        self[attr_name] = generate_holiday_passphrase
      end
    end
  end

  private

  def generate_holiday_passphrase
    passphrase = "#{HOLIDAY_VERBS.sample}#{HOLIDAY_VERBS.sample}#{HOLIDAY_NOUNS.sample}"
  end

  HOLIDAY_VERBS =
    [
      "holiday",
      "sparkly",
      "spangly",
      "deckedout",
      "woodsy",
      "cheery"
    ].freeze

  HOLIDAY_NOUNS =
    [
      "elf",
      "stocking",
      "garland",
      "tree",
      "present",
      "gift",
      "reindeer"
    ].freeze
end
