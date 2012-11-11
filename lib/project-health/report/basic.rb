module ProjectHealth
  class BasicReport

    attr_reader :name

    def initialize(oct, name)
      @name = name
    end

    def stats
      { "Name" => name }
    end
  end
end
