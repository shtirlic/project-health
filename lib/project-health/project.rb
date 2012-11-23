module ProjectHealth
  class Project

    attr_reader :name, :oct_client

    def initialize(name)
      @oct_client = Octokit::Client.new(auto_traversal: true,
                                 per_page: 500, login: config.login,
                                 password: config.password)
      @name = name
      @reports = []
      [:basic, :pull_requests, :issues].map(&method(:add_report))
    end

    def add_report(report)
      @reports << report
    end

    def delete_report(report)
      @reports.delete(report)
    end

    def stats
      result = {}
      @reports.map do |x|
        report = ProjectHealth.const_get("#{x}_report".camelize).new(self)
        result.merge!(report.stats)
      end
      { "Project" => result }
    end

  end
end
