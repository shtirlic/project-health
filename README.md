# Project Health

Library for calculating project health report and analysis based on GitHub Activity data

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'project-health'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install project-health
```

## Usage

```ruby
require 'pp'
require 'project-health'

ProjectHealth.configure do |config|
  #config.login = ''  # use your github name
  #config.password = '' # use your github password
end

project = ProjectHealth.new('capistrano/capistrano')

pp project.stats
```

Result

```ruby
{"Project"=>
  {"Name"=>"capistrano/capistrano",
   "Pull Requests"=>
    {"All"=>142,
     "Open"=>8,
     "Closed"=>134,
     "Open %"=>5.63,
     "Closed %"=>94.37,
     "Open/Closed % ratio"=>0.06,
     "Open time in days"=>801,
     "Min open time in days"=>5,
     "Max open time in days"=>389,
     "Average open time in days per request"=>100,
     "Health"=>"Good"}}}
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
