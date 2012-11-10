require 'octokit'
require 'json'

class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

class ProjectHealth

  attr_reader :pulls_open, :pulls_closed, :pulls_all
  attr_reader :name

  def initialize(name)
    @oct = Octokit::Client.new(:auto_traversal => true, :per_page => 500, :login => "", :password=>"")
    @name = name
    parse_data
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


  def stats
    {
      "Project" => {
        "Name" => name,

        "Pull Requests"=> {
          'all'      => pulls_all,
          'open'     => pulls_open,
          'closed'   => pulls_closed,
          'open %'   => pulls_open_percent.to_f.round(2),
          'closed %' => pulls_closed_percent.to_f.round(2),
          'open/close % ratio' => open_closed_pull_ratio.to_f.round(2),
          'health' => pulls_health
        }.delete_if{|k,v| v.kind_of?(Float) && v.nan?}
      }
    }
  end


  private

  def parse_data
    @pulls_open   = @oct.pull_requests(name, :open).count
    @pulls_closed = @oct.pull_requests(name, :closed).count
    @pulls_all    = pulls_open + pulls_closed
  end

end




repo_name = 'pengwynn/octokit'
project = ProjectHealth.new(repo_name)

puts JSON.pretty_generate project.stats

