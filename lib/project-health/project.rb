module ProjectHealth
  class Project

    attr_reader :name

    def initialize(name)
      @oct = Octokit::Client.new(:auto_traversal => true,
                                 :per_page => 500, :login => Config.login,
                                 :password=> Config.password)
      @name = name
      @reports = []
      add_report :basic
      add_report :pull_requests
    end

    def add_report(report)
      @reports << ProjectHealth.const_get("#{report}_report".to_s.camelize).new(@oct, name)
    end

    def stats
      result = {}
      @reports.map{|x| result.merge!(x.stats) }
      { "Project" => result }
    end

  end
end
