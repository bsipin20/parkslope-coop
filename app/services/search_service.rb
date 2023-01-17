module SearchServices
  class BaseSearch
    def initialize(min_date, max_date, options = {})
      @min_date = min_date
      @max_date = max_date
      @options = options
    end
    def results
      raise NotImplementedError
    end
  end

  class AggregateProduceSearch < BaseSearch
    def results
    end
  end
end
