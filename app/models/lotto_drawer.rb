class LottoDrawer
  def initialize(ticket)
    @ticket = ticket
    calculate
  end

  def calculate
    @draws = []
    @ticket.attempts.times { @draws << draw }
    @results = @draws.map do |draw|
      [ draw.join(" "),
        "You got #{match_result draw} ",
        winnings(draw)]
    end
    Game.create(:gain => total_winnings, :loss => total_expenses,
                :numbers => @ticket.numbers.join(" "))
  end

  def results
    @results
  end

  def total_winnings
    @results.inject(0) { |sum, x| sum + x[2] }
  end

  def total_expenses
    @ticket.attempts * 10
  end

  def net 
    total_winnings - total_expenses
  end

  def draw
    (1..@ticket.size).to_a.shuffle[0, @ticket.numbers.size]
  end

  def match_result(draw)
    result = @ticket.numbers & draw
    result.empty? ? "no correct" : "the number#{result.size != 1 ? "s" : ""} <strong>#{result.join " "}</strong> correct"
  end

  def winnings(draw)
    result = (@ticket.numbers & draw).size
    case result
    when 3
      40
    when 4
      600
    when 5
      23000
    when 6 
      10000000 
    else  
      0
    end
  end

end
