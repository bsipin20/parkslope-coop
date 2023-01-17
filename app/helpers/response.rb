module Response
  class JsonResponse
    def create_response()
    end
  end

  class Line < BaseGraph
    def initialize(values, result, message: {})
      @obj = create_response(values, result, message)
    end

    attr_accessor :obj

    private

    def create_response(values, result, message)
      res = {}
      values.each do |row|
        if obj.contains(row:value)
          obj[valu]
        else
          obj[]
        end
      end
      res
    end
    end
end
