class SearchPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      claims = scope.select { |claim| claim.class.to_s == 'Claim' }
      tags = scope.select { |tag| tag.class.to_s == 'Tag' }
      if admin?
        scope
      elsif user?
        scope = (claims.select { |claim| claim.publicly? } + claims.select { |claim| claim.user_id == user.id &&
          !claim.publicly? } + claims_with_participants(claims)).uniq + tags
      else
        scope = claims.select { |claim| claim.publicly? } + tags
      end
    end

    private

    def claims_with_participants(claims)
      claims.map! do |claim|
        claim unless claim&.loan_participants.find_by(user_id: user.id).nil?
      end
      claims = claims.compact unless claims.compact.empty?
    end
  end

  def search?
    true
  end
end
