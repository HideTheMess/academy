module ApplicationHelper
  def flash_below_header
    notice = []

    flash[:notices].try(:each) do |msg|
      notice << msg
    end

    notice.join("\n").html_safe
  end

  def object_id_and_name(object)
    "#{ object.id }: #{ object.name }".html_safe
  end
end
