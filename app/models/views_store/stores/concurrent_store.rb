require_relative "../cleanup_strategy"

module ViewsStore
  module Stores
    class ConcurrentStore < AbstractStore
      attr_accessor :timeout

      def initialize(timeout:, cleanup_strategy: SimpleCleanupStrategy.new)
        @store = Concurrent::Map.new
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
        @store.compute(key_id) do |values|
          values = Hash.new unless values
          values[value_id] = current_time
          values
        end
      end

      def cleanup(key_id)
        permissible_time = current_time - timeout
        @store.compute(key_id) do |values|
          values ? @cleanup_strategy.cleanup_hash(values, permissible_time) : nil
        end
      end

      def size_of(key_id)
        size = 0
        @store.compute_if_present(key_id) do |values|
          size = values.size
          values
        end
        size
      end
    end
  end
end
