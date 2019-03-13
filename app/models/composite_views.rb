class CompositeViews
  attr_accessor :video_id
  attr_accessor :customer_id

  def initialize(video_id, customer_id)
    @video_id = video_id
    @customer_id = customer_id
  end

  def visit
    CustomerViews.new(customer_id).visit(video_id)
    VideoViews.new(video_id).visit(customer_id)
  end

  class << self
    include Enumerable

    def each
      yield CustomerViews
      yield VideoViews
    end

    def cleanup_all
      each do |views_store_class|
        views_store_class.cleanup_all
      end
    end
  end
end
