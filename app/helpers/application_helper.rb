module ApplicationHelper
  def flash_class(level)
    return "alert alert-" + level
  end
end
