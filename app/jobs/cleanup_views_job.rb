class CleanupViewsJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    CleanupViewsJob.perform_next
  end

  def perform(*args)
    CompositeViews.cleanup_all
  end

  def self.perform_next
    CleanupViewsJob.set(wait: Rails.configuration.views_store_cleanup).perform_later
  end
end
