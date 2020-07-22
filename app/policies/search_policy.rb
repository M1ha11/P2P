class SearchPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      claims(scope) + tags(scope)
    end

    private

    def claims(scope)
      claims_array = scope.select { |claim| claim.class.to_s == 'Claim' }
      claims = Claim.where(id: claims_array.map(&:id))
      ClaimPolicy::Scope.new(user, claims).resolve
    end

    def tags(scope)
      tags_array = scope.select { |tag| tag.class.to_s == 'Tag' }
      tags = Tag.where(id: tags_array.map(&:id))
      TagPolicy::Scope.new(user, tags).resolve
    end
  end

  def search?
    true
  end
end
