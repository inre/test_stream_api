module ViewsStore
  class StoreFactory
    class << self
      def create(**params)
        self.new(**params).create
      end
    end

    def initialize(type:, timeout:, name: nil, url: nil)
      @type = type
      @timeout = timeout
      @name = name
      @url = url
    end

    def create
      case @type
      when :concurrent_store
        store_class.new(
          timeout: @timeout
        )
      when :local_store
        store_class.new(
          timeout: @timeout
        )
      when :redis_store
        store_class.new(
          timeout: @timeout,
          prefix: "#{@name}:",
          url: @url
        )
      else
        raise "Unsupported store type"
      end
    end

    private

    def store_class
      "::ViewsStore::Stores::#{@type.to_s.classify}".constantize
    end
  end
end
