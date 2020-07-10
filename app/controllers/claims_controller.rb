class ClaimsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show confirm]

  def index
    @tag ||= params[:tag]
    @sort = params[:sort]
    @direction = params[:direction]
    claims = Claims::Filter.new(policy_scope(Claim), params).call
    sort_claims = Claims::Sort.new(claims, params[:sort], params[:direction]).call
    @claims = Global::Pagination.new(sort_claims, params[:page], Claim::PER_PAGE).paginate
    respond_with @claims, location: -> { claims_path }
  end

  def statistic
    @sort, @direction = params[:sort], params[:direction]
    @claims = Claims::Sort.new(policy_scope(Claim), @sort, @direction).call
    respond_with @claim, location: -> { statistic_claims_path }
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
      claim.confirm!
      claim.update(confirmed_at: Time.zone.now)
    end
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
    @statuses = Claim.statuses.slice(:privatly, :publicly).keys
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
