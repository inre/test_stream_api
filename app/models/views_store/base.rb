module ViewsStore
  class Base
    def visit(value_id)
      store.touch(views_store_key_id, value_id)
    end

    def store
      self.class.store
    end

    def views_count
      store.size_of(views_store_key_id)
    end

    def cleanup
      store.cleanup(views_store_key_id)
    end

    def views_store_key_id
      raise NotImplementedError
    end

    class << self
      def store=(new_store)
        class_variable_set(:@@store, new_store)
      end

      def store
        raise "You should initialize #{self.class}.store before use it." unless class_variable_defined?(:@@store)
        class_variable_get(:@@store)
      end

      def cleanup_all
        store.cleanup_all
      end
    end
  end
end
