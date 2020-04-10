class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def admin?
    user.admin? if user
  end

  def user?
    user.user? if user
  end

  def belongs_to_user?(record)
    record.user == user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    def admin?
      user.admin? if user
    end

    def user?
      user.user? if user
    end

    def belongs_to_user?(scope)
      scope.user == user
    end
  end
end
