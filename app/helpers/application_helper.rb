module ApplicationHelper
  def curr_user
    "#{session[:user][:name]}"
  end
end
