require "active_support/core_ext"
require 'octokit'

class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

module ProjectHealth
  module Config
    mattr_accessor :login, :password
    def configure
      yield self
    end
  end
end
