class ClaimsController < ApplicationController
  def index
    @claims = Claim.where(status: 'publicly')
    respond_with @claims, location: -> { claims_path }
  end

  def new
    set_service
    @claim = Claim.new
  end

  def create
    @claim = current_user.claims.build(claim_params)
    if @claim.save
      respond_with @claim, location: -> { claim_path(claim.id) }
    else
      set_service
      respond_with @claim, location: -> { new_claim_path }
    end
  end

  def edit; end

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

  def set_service
    @currencies = Claims::Currency.new.list
    @rates = Claims::Rate.new.list
  end

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
