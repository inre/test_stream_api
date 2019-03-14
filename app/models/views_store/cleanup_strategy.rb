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
end
