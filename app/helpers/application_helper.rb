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

  def user_guide_link(company_name, object_type)
    link = "https://s3-us-west-2.amazonaws.com/arciplex-user-guides/"
    yaml = YAML.load_file("#{Rails.root}/config/user_guides.yml")[company_name.downcase]

    if yaml[object_type]
      link_to "User Guide", "#{link}#{yaml[object_type]}", { target: "_blank" }
    else
      nil
    end
  end

end
