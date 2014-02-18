module ApplicationHelper
  
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-danger", notice: "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    gritters = []
    flash.each do |msg_type, message|
      gritters << add_gritter(message, image: msg_type, time: 1500)
    end
    
    gritters.join(", ")
  end
  
  def page_heading(title)
    content_tag :h1, title
  end
  
end
