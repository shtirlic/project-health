require 'project-health/version'
require 'project-health/config'
require 'project-health/reports'
require 'project-health/project'

module ProjectHealth
  class << self
    def new(*args)
      Project.new(*args)
    end
    def configure(&block)
      Project.configure(&block)
    end
  end
end
