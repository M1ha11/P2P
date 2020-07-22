class SearchPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      claims_array = scope.select { |claim| claim.class.to_s == 'Claim' }
      tags_array = scope.select { |tag| tag.class.to_s == 'Tag' }
      claims = Claim.where(id: claims_array.map(&:id))
      tags = Tag.where(id: tags_array.map(&:id))
      claim_policy = ClaimPolicy::Scope.new(user, claims).resolve
      tag_policy = TagPolicy::Scope.new(user, tags).resolve
      claim_policy + tag_policy
    end
  end

  def search?
    true
  end
end
