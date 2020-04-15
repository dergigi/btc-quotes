class QuotesController < ApplicationController
  include HttpAuthConcern
  
  before_action :set_quote, only: [:show]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all
  end

  def random
    @quote = Quote.find(Quote.ids.shuffle.first)

    respond_to do |format|
      format.html { render :pretty }
      format.json { render :show, status: :ok, location: @quote }
    end
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
