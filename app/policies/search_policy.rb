class SearchPolicy < ApplicationPolicy
  class Scope < Scope
    MODELS_FOR_SEARCH = %w(Claim Tag).freeze

    def resolve
      search_scope = MODELS_FOR_SEARCH.each_with_object([]) do |klass, memo|
        collection = scope.select { |model| model.class.to_s == klass }
        relation = klass.constantize.where(id: collection.map(&:id))
        policy_klass = "#{klass}Policy"
        authorized_relation = policy_klass.constantize::Scope.new(user, relation).resolve
        memo.push(authorized_relation)
      end
      search_scope.flatten
    end
  end

  def search?
    true
  end
end
