class CustomerViews < ViewsStore::Base
  attr_accessor :customer_id

  def initialize(customer_id)
    @customer_id = customer_id
  end

  def views_store_key_id
    @customer_id
  end

  def self.views_store_name
    'customers'
  end
end
