module ProjectHealth
  class IssuesReport

    attr_reader :open, :closed, :all

    def initialize(oct, name)
      @open_times = []
      @open   = oct.issues(name, {state: :open}).tap{|x| x.each(&method(:calc_open_issue_time)) }.count
      @closed = oct.issues(name, {state: :closed}).count
      @all    = open + closed
    end

    def stats
      {
        "Issues"=>
        {
          'All'      => all,
          'Open'     => open,
          'Closed'   => closed,
          'Open %'   => open_percent.to_f.round(2),
          'Closed %' => closed_percent.to_f.round(2),
          'Open/Closed % ratio' => open_closed_ratio.to_f.round(2),
          'Open time in days' => open_time,
          'Min open time in days' => min_open_time,
          'Max open time in days' => max_open_time,
          'Average days issue is opened' => average_open_time,
          'Health' => health
        }
      }.delete_if{|k,v| v.kind_of?(Float) && v.nan?}
    end

    def open_percent
      open.percent_of all
    end

    def closed_percent
      closed.percent_of all
    end

    def open_closed_ratio
      result = open_percent / closed_percent
    end

    def open_time
      @open_times.inject(:+) || 0
    end

    def average_open_time
      open_time / open if open > 0
    end

    def min_open_time
      @open_times.min
    end

    def max_open_time
      @open_times.max
    end

    def health
      case open_closed_ratio.to_f
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
    def calc_open_issue_time(issue)
      @open_times << (DateTime.now.to_i - issue.created_at.to_datetime.to_i)/60/60/24
    end
  end
end
