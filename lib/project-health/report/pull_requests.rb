module ProjectHealth
  class PullRequestsReport

    attr_reader :pulls_open, :pulls_closed, :pulls_all

    def initialize(oct, name)
      @pull_open_time = []
      @pulls_open   = oct.pull_requests(name, :open).tap{|x| x.each(&method(:calc_open_pull_time)) }.count
      @pulls_closed = oct.pull_requests(name, :closed).count
      @pulls_all    = pulls_open + pulls_closed
    end

    def stats
      {
        "Pull Requests"=>
        {
          'All'      => pulls_all,
          'Open'     => pulls_open,
          'Closed'   => pulls_closed,
          'Open %'   => pulls_open_percent.to_f.round(2),
          'Closed %' => pulls_closed_percent.to_f.round(2),
          'Open/Closed % ratio' => open_closed_pull_ratio.to_f.round(2),
          'Open time in days' => pull_open_time,
          'Min open time in days' => pull_min_open_time,
          'Max open time in days' => pull_max_open_time,
          'Average days request is opened' => pull_average_open_time,
          'Health' => pulls_health
        }
      }.delete_if{|k,v| v.kind_of?(Float) && v.nan?}
    end

    def pulls_open_percent
      pulls_open.percent_of(pulls_all)
    end

    def pulls_closed_percent
      pulls_closed.percent_of(pulls_all)
    end

    def open_closed_pull_ratio
      result = pulls_open_percent / pulls_closed_percent
    end

    def pull_open_time
      @pull_open_time.inject(:+)
    end

    def pull_average_open_time
      pull_open_time / pulls_open
    end

    def pull_min_open_time
      @pull_open_time.min
    end

    def pull_max_open_time
      @pull_open_time.max
    end

    def pulls_health
      case open_closed_pull_ratio.to_f
      when 0..0.1
        "Good"
      when 0.1..0.2
        "Normal"
      when 0.2..1
        "Bad"
      else
        "Unknown"
      end
    end

    private
    def calc_open_pull_time(pull)
      @pull_open_time << (DateTime.now.to_i - pull.created_at.to_datetime.to_i)/60/60/24
    end
  end
end
