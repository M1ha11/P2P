class CardsController < ApplicationController
  def index
    binding.pry
    @cards = policy_scope(Card)
    respond_with @cards, location: -> { cards_path }
  end

  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.build(card_params)
    authorize @card
    @card.save
    respond_with @card, location: -> { cards_path }
  end

  def destroy
    @card = Card.find(params[:id])
    authorize @card
    @card.destroy
    respond_with @card, location: -> { cards_path }
  end

  private

  def flash_interpolation_options
    { resource_errors: @card.errors.full_messages.join(',') }
  end

  def card_params
    params.require(:card).permit(:card_number, :expire_date, user: [:id])
  end
end
