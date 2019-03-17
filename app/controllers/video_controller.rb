class VideoController < ApplicationController
  include RenderResponse

  def visit
    composite_views = CompositeViews.new(params[:video_id], params[:customer_id])
    composite_views.visit

    render json: {
      success: true
    }
  end

  def views
    video_views = VideoViews.new(params[:video_id])
    views_count = video_views.views_count
    render json: {
      views: views_count
    }
  end
end
