require "active_support/core_ext"
require 'octokit'

class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

module ProjectHealth
  class Project
    include ActiveSupport::Configurable
    config_accessor :login, :password
    self.login = ENV["GITHUB_USERNAME"]
    self.password = ENV["GITHUB_PASSWORD"]
  end
end
