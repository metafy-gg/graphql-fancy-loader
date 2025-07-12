module GraphQL
  class FancyConnection < GraphQL::Pagination::RelationConnection
    def initialize(loader, args, key, **super_args)
      @loader = loader
      @args = args
      @key = key
      @then = nil

      super(nil, **super_args)
    end

    # @return [Array<ApplicationRecord>]
    def nodes
      resolved_nodes = base_nodes
      if @then
        @then.call(resolved_nodes)
      else
        resolved_nodes
      end
    end

    def edges
      @edges ||= begin
        resolved_nodes = nodes
        resolved_nodes.map { |n| @edge_class.new(n, self) }
      end
    end

    # @return [Integer]
    def total_count
      results = base_nodes
      if results.first
        results.first.attributes['total_count']
      else
        0
      end
    end

    # @return [Boolean]
    def has_next_page # rubocop:disable Naming/PredicateName
      results = base_nodes
      if results.last
        results.last.attributes['row_number'] < results.last.attributes['total_count']
      else
        false
      end
    end

    # @return [Boolean]
    def has_previous_page # rubocop:disable Naming/PredicateName
      results = base_nodes
      if results.first
        results.first.attributes['row_number'] > 1
      else
        false
      end
    end

    def start_cursor
      results = base_nodes
      cursor_for(results.first)
    end

    def end_cursor
      results = base_nodes
      cursor_for(results.last)
    end

    def cursor_for(item)
      item && encode(item.attributes['row_number'].to_s)
    end

    def then(&block)
      @then = block
      self
    end

    private

    def base_nodes
      @base_nodes ||= context.dataloader.with(@loader, **loader_args).load(@key)
    end

    def after_offset
      @after_offset ||= after && decode(after).to_i
    end

    def before_offset
      @before_offset ||= before && decode(before).to_i
    end

    def loader_args
      @args.merge(
        before: before_offset,
        after: after_offset,
        first: first,
        last: last,
        context: context
      )
    end
  end
end
