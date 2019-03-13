module ViewsStore
  class AbstractStore
    include Enumerable

    def touch(key_id, value_id)
      raise NotImplementedError
    end

    def cleanup(key_id)
      raise NotImplementedError
    end

    def size_of(key_id)
      raise NotImplementedError
    end

    def cleanup_all
      each do |key_id|
        cleanup(key_id)
      end
    end
  end
end
