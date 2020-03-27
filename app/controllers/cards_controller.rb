class CardsController < ApplicationController
  before_action :authenticate_user!
  responders :flash
  respond_to :html

  def index
    @cards = Card.all
    respond_with @cards, location: -> { cards_path }
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.create(card_params)
    binding.pry
    respond_with @card, location: -> { cards_path }
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    respond_with @card, location: -> { cards_path }
  end

  private

  def card_params
    params.require(:card).permit(:card_number, :expire_date)
  end
end
