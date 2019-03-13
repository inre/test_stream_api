require_relative "../cleanup_strategy"

module ViewsStore
  module Stores
    class LocalStore < AbstractStore
      attr_accessor :timeout

      def initialize(timeout:, cleanup_strategy: SimpleCleanupStrategy.new)
        @store = Hash.new
        @timeout = timeout
        @cleanup_strategy = cleanup_strategy
      end

      def current_time
        Time.now.to_i
      end

      def each(&block)
        @store.each_key(&block)
      end

      def touch(key_id, value_id)
        values = @store[key_id]
        values = Hash.new unless values
        values[value_id] = current_time
        @store[key_id] = values
      end

      def cleanup(key_id)
        permissible_time = current_time - timeout
        values = @store[key_id]
        @store[key_id] = @cleanup_strategy.cleanup_hash(values, permissible_time) if values
      end

      def size_of(key_id)
        values = @store[key_id]
        values ? values.size : 0
      end
    end
  end
end
