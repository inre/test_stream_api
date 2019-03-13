class CustomerController < ApplicationController
  include RenderResponse

  before_action do
    @customer_views = CustomerViews.new(params[:customer_id])
  end

  def views
    # Should actualize customer views before
    @customer_views.cleanup

    views_count = @customer_views.views_count
    render_response(
      views: views_count
    )
  end
end
