module ClaimsHelper
  def not_collected_amount_of_money?
    @claim.loan_participants.sum(:money) < @claim.amount
  end

  def collected_amount?
    @claim.amount == @claim.loan_participants.sum(:money)
  end

  def statistic_header(sort_field)
    link_to I18n.t("activerecord.attributes.claim.#{sort_field}"), statistic_claims_path(sort: sort_field,
                                         direction: @sort == sort_field && @direction == 'asc' ? 'desc' : 'asc'),
            class: 'stat-head'
  end

  def sort_arrow(sort_field)
    if @sort == sort_field && @direction == 'asc'
      fa_icon 'sort-down'
    elsif @sort == sort_field && @direction == 'desc'
      fa_icon 'sort-up'
    end
  end

  def initial_status?
    @claim.publicly? || @claim.privatly?
  end

  def statuses_for_delete?
    initial_status? || @claim.archived?
  end
end
