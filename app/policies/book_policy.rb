class BookPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    # 这里校验的是resource等于Book, 因为是新建没有具体的资源
    user.has_any_role?(:admin, { :name => :editor, :resource => Book})
  end

  def create?
    user.has_any_role?(:admin, { :name => :editor, :resource => Book})
  end

  def update?
    # 这里校验的是某个具体的资源
    user.has_any_role?(:admin, { :name => :editor, :resource => record})
  end

  def destroy?
    user.has_any_role?(:admin, { :name => :editor, :resource => record})
  end

  class Scope < Scope
    def resolve
      if user.try :admin
        scope.all
      else
        scope.where(title: 'Ruby元编程')
      end
    end

    def update?
      user.try :admin || record.title == 'Ruby元编程'
    end
  end
end