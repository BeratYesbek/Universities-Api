# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :entity, :role

  def initialize(user, entity, role)
    @user = user
    @entity = entity
    @role = role
  end

  def index?
    #user.role == role
    false
  end

  def show?
    #user.role == role
    false
  end

  def create?
    user.role == role

  end

  def new?
    create?
  end

  def update?
    user.role == role
  end

  def edit?
    update?
  end

  def destroy?
    user.role == role
  end

end
