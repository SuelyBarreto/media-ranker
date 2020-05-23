module ApplicationHelper

  def flash_class(level)
    return "alert alert-" + level
  end

  def button_logged
    user = User.find_by(id: session[:user_id])
    if user
      return link_to "Logged in as " + user.name, user_path(user.id), class: "btn btn-primary"
    else
      return ""
    end 
  end

  def button_logout
    user = User.find_by(id: session[:user_id])
    if user
      button_to "Logout", logout_path, method: "post", class: "btn btn-primary"
    else
      return ""
    end 
  end

  def button_login
    user = User.find_by(id: session[:user_id])
    if user
      return ""
    else
      button_to "Login", login_path, method: "get", class: "btn btn-primary" 
    end 
  end

end