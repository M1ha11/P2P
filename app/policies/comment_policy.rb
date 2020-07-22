class CommentPolicy < ApplicationPolicy
  def create?
    user? || admin? && not_default_user?
  end

  def new?
    user? || admin? && not_default_user?
  end

  def destroy?
    belongs_to_user? || admin? && not_default_user?
  end
end
