class ApplicationPolicy
  attr_reader :user, :record
  delegate :admin?, :user?, to: :user, allow_nil: true

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

  def belongs_to_user?
    record.user == user
  end

  def not_default_user?
    user.present? && user.email != User::DEFAULT_EMAIL && user.profile.address != User::DEFAULT_ADDRESS &&
      user.profile.phone_number != User::DEFAULT_PHONE_NUMBER
  end

  class Scope
    attr_reader :user, :scope
    delegate :admin?, :user?, to: :user, allow_nil: true

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    def belongs_to_user?
      scope.user == user
    end
  end
end
