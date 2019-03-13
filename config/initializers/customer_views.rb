url = Rails.configuration.views_store_url rescue nil
CustomerViews.store = ViewsStore::StoreFactory.create(
  type: Rails.configuration.views_store_type,
  timeout: Rails.configuration.views_store_timeout,
  name: CustomerViews.views_store_name,
  url: url
)
