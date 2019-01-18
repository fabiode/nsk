module ApplicationHelper
  def icon(icon_name)
    content_tag :i, '', class: "fa fa-#{icon_name}"
  end

  def icon_text(icon_name, text)
    [icon(icon_name), text].join(' ').html_safe
  end

  def flash_class(level)
    level = level.to_sym
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end
end
