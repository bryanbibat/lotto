class HomeController < ApplicationController

  def index
    @ticket = Ticket.new
    set_stats
  end
  
  def process_ticket
    @ticket = Ticket.new(params[:ticket])
    if @ticket.valid?
      @lotto = LottoDrawer.new(@ticket)
    end
    set_stats
    render :action => "index"
  end

  private
    def set_stats
      @winnings = Game.sum("gain")
      @loss = Game.sum("loss")
    end
end
