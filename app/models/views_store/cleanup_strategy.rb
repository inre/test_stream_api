module ViewsStore
  class CleanupStrategy
    def cleanup_hash(values, permissible_time)
      raise NotImplementedError
    end
  end

  class SimpleCleanupStrategy < CleanupStrategy
    def cleanup_hash(values, permissible_time)
      values.delete_if { |value_id, time| time < permissible_time }
    end
  end

  class OptimizedCleanupStrategy < CleanupStrategy
    def cleanup_hash(values, permissible_time)
      hash = Hash.new
      values.reverse_each do |value_id, time|
        return if time < permissible_time
        hash[value_id] = time
      end
      hash
    end
  end
end
