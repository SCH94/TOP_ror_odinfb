module UsersHelper
  def find_user(id)
    User.find(id)
  end
end