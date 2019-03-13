url = Rails.configuration.views_store_url rescue nil
VideoViews.store = ViewsStore::StoreFactory.create(
  type: Rails.configuration.views_store_type,
  timeout: Rails.configuration.views_store_timeout,
  name: VideoViews.views_store_name,
  url: url
)
