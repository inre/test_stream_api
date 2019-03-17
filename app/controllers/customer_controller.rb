class CustomerController < ApplicationController
  include RenderResponse

  def views
    customer_views = CustomerViews.new(params[:customer_id])
    # Should actualize customer views before
    customer_views.cleanup

    views_count = customer_views.views_count
    render json: {
      views: views_count
    }
  end
end
