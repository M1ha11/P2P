class CommentPolicy < ApplicationPolicy
  def create?
    user? || admin?
  end

  def new?
    user? || admin?
  end

  def destroy?
    belongs_to_user? || admin?
  end

  private

  def comment
    record
  end
end
