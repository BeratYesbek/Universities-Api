class AdminPolicy < ApplicationPolicy
  def initialize(user, entity, role = "admin")
    super(user, entity, role)
  end
end
