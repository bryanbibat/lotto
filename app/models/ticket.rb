class Ticket 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :numbers, :size, :attempts

  validates_presence_of :attempts
  validate :numbers_must_be_6
  validate :attempt_must_be_valid

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    self.numbers = numbers.map { |x| x.to_i } if numbers
    self.attempts = attempts.to_i if attempts
    self.size = 45
  end

  def persisted?
    false
  end

  private
    def numbers_must_be_6
      if !numbers or numbers.size != 6
        errors[:base] << "You must select exactly 6 numbers"
      end

    end

    def attempt_must_be_valid
      if ![1, 104, 1040].include? attempts
        errors.add(:attempts, "is invalid")
      end
    end

end
