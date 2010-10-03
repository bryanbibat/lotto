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
    @ticket.attempts * (@ticket.size > 45 ? 20 : 10)
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

  PrizeMatrix = { 
    42 => { 3 => 20, 4 => 500, 5 => 20000, 6 => 6000000 },
    45 => { 3 => 40, 4 => 600, 5 => 23000, 6 => 10000000 },
    49 => { 3 => 100, 4 => 1000, 5 => 56000, 6 => 15000000 },
    55 => { 3 => 150, 4 => 2000, 5 => 150000, 6 => 30000000 }}


  def winnings(draw)
    result = (@ticket.numbers & draw).size
    return 0 if result < 3
    PrizeMatrix[@ticket.size][result]
  end

end
