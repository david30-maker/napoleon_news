module ApplicationHelper
  def possessivize(name)
    return "" if name.blank?

    name.end_with?('s') ? "#{name}'" : "#{name}'s"
  end
end
