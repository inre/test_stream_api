class VideoController < ApplicationController
  include RenderResponse

  before_action do
  end

  def visit
    composite_views = CompositeViews.new(params[:video_id], params[:customer_id])
    composite_views.visit
    
    render_response(
      success: true
    )
  end

  def views
    video_views = VideoViews.new(params[:video_id])
    views_count = video_views.views_count
    render_response(
      views: views_count
    )
  end
end
