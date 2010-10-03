class Ticket 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :numbers, :size, :attempts

  AttemptsDropdown =  [["1 time", 1], 
    ["104 times (twice a week for a year)", 104], 
    ["1,040 times (twice a week for 10 years)", 1040]]

  SizeDropdown =  [["Lotto 6/42", 42], 
    ["MegaLotto 6/45", 45], 
    ["SuperLotto 6/49", 49],
    ["GrandLotto 6/55", 55]]

  validates_presence_of :attempts, :size
  validate :numbers_must_be_6
  validate :attempt_must_be_valid, :size_must_be_valid, :numbers_must_be_within_size

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    self.numbers = (numbers.map { |x| x.to_i }).uniq if numbers
    self.attempts = attempts.to_i if attempts
    self.size = size.to_i if size 
  end

  def persisted?
    false
  end

  def include?(number)
    numbers and numbers.include?(number)
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

    def size_must_be_valid
      if ![42, 45, 49, 55].include? size
        errors.add(:size, "is invalid")
      end
    end
    
    def numbers_must_be_within_size
      if numbers.any? { |x| x < 1 }
        errors.add(:numbers, "is invalid")
      end
      if numbers.any? { |x| x > size }
        errors.add(:numbers, "must be less than or equal to #{size}")
      end
    end
end
