module JobsHelper
  def render_job_status(job)
    if job.is_hidden
      content_tag(:span, "lock", class: "material-icons", style:"vertical-align: text-bottom")
    else
      content_tag(:span, "public", class: "material-icons", style:"vertical-align: text-bottom")
    end
  end
end
