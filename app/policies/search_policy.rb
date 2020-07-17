class SearchPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      claims = scope.select { |claim| claim.class.to_s == 'Claim' }
      tags = scope.select { |tag| tag.class.to_s == 'Tag' }
      if admin?
        scope
      elsif user?
        (claims.select { |claim| claim.publicly? } + claims.select { |claim| claim.user_id == user.id &&
          !claim.publicly? }).uniq! + tags
      else
        claims.select { |claim| claim.publicly? } + tags
      end
    end
  end

  def search?
    true
  end
end
