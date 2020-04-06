class ClaimsController < ApplicationController
   def index
    @claims = Claim.where(status: 'publicly')
    respond_with @claims, location: -> { claims_path }
  end

  def new
    @currencies = Claims::Currency.new.list
    @rates = Claims::Rate.new.list
    @claim = Claim.new
  end

  def create
    binding.pry
    @claim = current_user.claims.build(claim_params)
    @claim.save
    respond_with @claim, location: -> { claim_path(claim.id) }
  end

  def edit
  end

  def update
    claim.update(claim_params)
    respond_with claim, location: -> { claim_path(claim.id) }
  end

  def show
    respond_with claim, location: -> { claim_path(claim.id) }
  end

  def destroy
    claim.destroy
    respond_with claim, location: -> { claims_path }
  end

  private

  def claim
    @claim ||= Claim.find(params[:id])
  end

  def flash_interpolation_options
    { resource_errors: claim.errors.full_messages.join(',') }
  end

  def claim_params
    params.require(:claim).permit(:amount, :currency, :goal, :interest_rate, :repayment_period, :payment_frequency,
                                  :status, user: [:id])
  end
end
