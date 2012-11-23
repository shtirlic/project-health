module ProjectHealth
  class BasicReport

    attr_reader :name, :title, :language, :stars,
                :created, :last_push, :description

    def initialize(project)
      @name        = project.name
      repo         = project.oct_client.repo(name)
      @language    = repo["language"]
      @stars       = repo["watchers_count"]
      @created     = repo["created_at"]
      @last_push   = repo["pushed_at"]
      @description = repo["description"]
    end

    def stats
      {
        "Basic" =>
        {
          "Name"        => name,
          "Description" => description,
          "Created"     => created,
          "Last push"   => last_push,
          "Language"    => language,
          "Stars"       => stars
        }
       }
    end
  end
end
