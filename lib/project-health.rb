require 'project-health/version'
require 'project-health/config'
require 'project-health/reports'
require 'project-health/project'

module ProjectHealth
  class << self
    def new(*args)
      ProjectHealth::Project.new(*args)
    end
  end
end
