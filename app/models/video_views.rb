class VideoViews < ViewsStore::Base
  attr_accessor :video_id

  def initialize(video_id)
    @video_id = video_id
  end

  def views_store_key_id
    @video_id
  end

  def self.views_store_name
    'videos'
  end
end
