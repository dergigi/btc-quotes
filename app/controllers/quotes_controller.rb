class QuotesController < ApplicationController
  before_action :set_quote, only: [:show]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all
  end

  def random
    @quote = Quote.find(Quote.ids.shuffle.first)
    
    render :pretty, location: @quote
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:author, :body, :source, :date, :audio)
    end
end
