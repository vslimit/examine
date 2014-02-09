module ApplicationHelper
  def curr_user
    p 1234
    "#{session[:user][:name]}"
  end
end
