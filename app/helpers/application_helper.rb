module ApplicationHelper
  def icon(icon_name)
    content_tag :i, '', class: "fa fa-#{icon_name}"
  end

  def icon_text(text, icon_name)
    [icon(icon_name), text].join(' ').html_safe
  end
end
