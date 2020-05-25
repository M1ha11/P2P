class ClaimsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show confirm]

  def index
    @claims = Claims::Sort.new(policy_scope(Claim), params[:sort], params[:direction]).call
    respond_with @claims, location: -> { claims_path }
  end

  def new
    set_service
    @claim = Claim.new
    authorize @claim
  end

  def create
    @claim = current_user.claims.build(claim_params)
    authorize @claim
    if @claim.save
      respond_with @claim, location: -> { claim_path(claim.id) }
    else
      set_service
      respond_with @claim, location: -> { new_claim_path }
    end
  end

  def confirm
    ActiveRecord::Base.transaction do
      claim.update(status: 'confirmed')
      claim.user.profile.update(success_credit_project: claim.user.profile.success_credit_project + 1)
      claim.loan_participants.each do |participant|
        participant.user.profile.update(success_lend_project: participant.user.profile.success_lend_project + 1)
      end
    end
    # claim.confirm!
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
    @statuses = []
    @statuses < Claim.statuses[:publicly] << Claim.statuses[:privatly]
  end

  def claim
    @claim ||= Claim.find(params[:id])
    authorize @claim
  end

  def flash_interpolation_options
    { resource_errors: claim.errors.full_messages.join(',') }
  end

  def claim_params
    params.require(:claim).permit(:amount, :currency, :goal, :interest_rate, :repayment_period, :payment_frequency,
                                  :status, user: [:id])
  end
end
