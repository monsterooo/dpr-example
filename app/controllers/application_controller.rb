class ApplicationController < ActionController::Base
  include Pundit

  # 捕获没有授权的异常
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    # 针对这个异常做出具体的处理
    def user_not_authorized
      flash[:error] = "You are not authorized to perform this action."
      redirect_to '/'
    end
end
