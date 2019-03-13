require 'thread'

module ViewsStore
  module Stores
    class RedisStore < AbstractStore
      attr_accessor :timeout

      def initialize(prefix:, url:, timeout:)
        @redis = Redis.new(url: url)
        @prefix = prefix
        @semaphore = Mutex.new
        @timeout = timeout
      end

      def key_path(name)
        "#{@prefix}#{name.to_i}"
      end

      def all_key_path
        @all_key ||= "#{@prefix}all"
      end

      def current_time
        Time.now.to_i
      end

      def each(&block)
        @semaphore.synchronize do
          @redis.smembers(all_key_path)
        end.each(&block)
      end

      def touch(key_id, value_id)
        @semaphore.synchronize do
          @redis.sadd all_key_path, key_id
          @redis.zadd key_path(key_id), current_time, value_id.to_s
        end
      end

      def cleanup(key_id)
        @semaphore.synchronize do
          permissible_time = current_time - timeout
          @redis.zremrangebyscore key_path(key_id), '-inf', permissible_time
        end
      end

      def size_of(key_id)
        @semaphore.synchronize do
          @redis.zcount key_path(key_id), '-inf', '+inf'
        end
      end
    end
  end
end
