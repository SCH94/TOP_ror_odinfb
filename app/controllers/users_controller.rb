class UsersController < ApplicationController
  def index
  end

  def show
    @current_user ||= current_user
  end
end
