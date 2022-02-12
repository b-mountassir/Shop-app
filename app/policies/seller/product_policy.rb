class Seller::ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def create?
    user.has_role?(:seller) || user.has_role?(:admin)
  end
  def destroy?
    user == record.seller || user.has_role?(:admin)
  end
  def edit?
    user == record.seller || user.has_role?(:admin)
  end
  def update?
    user == record.seller || @user.has_role?(:admin)
  end
end
