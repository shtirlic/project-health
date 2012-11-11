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

From command line

```bash
project-health capistrano/capistrano
```

Result

```
Showing project health for capistrano/capistrano

Basic
┌─────────────┬─────────────────────────────────────┐
│ Name        ╎ capistrano/capistrano               │
│ Description ╎ Remote multi-server automation tool │
│ Created     ╎ 2009-02-26T16:14:04Z                │
│ Last push   ╎ 2012-11-09T07:48:26Z                │
│ Language    ╎ Ruby                                │
│ Stars       ╎ 2853                                │
└─────────────┴─────────────────────────────────────┘

Pull Requests
┌────────────────────────────────┬───────┐
│ All                            ╎ 142   │
│ Open                           ╎ 8     │
│ Closed                         ╎ 134   │
│ Open %                         ╎ 5.63  │
│ Closed %                       ╎ 94.37 │
│ Open/Closed % ratio            ╎ 0.06  │
│ Open time in days              ╎ 804   │
│ Min open time in days          ╎ 6     │
│ Max open time in days          ╎ 390   │
│ Average days request is opened ╎ 100   │
│ Health                         ╎ Good  │
└────────────────────────────────┴───────┘

```


From code

```ruby
require 'pp'
require 'project-health'

ProjectHealth.config do |c|
  #c.login = ''  # use your github name
  #c.password = '' # use your github password
end

project = ProjectHealth.new('capistrano/capistrano')

pp project.stats
```

Result

```ruby
{"Project"=>
  {"Basic"=>
    {"Name"=>"capistrano/capistrano",
     "Description"=>"Remote multi-server automation tool",
     "Created"=>"2009-02-26T16:14:04Z",
     "Last push"=>"2012-11-09T07:48:26Z",
     "Language"=>"Ruby",
     "Stars"=>2853},
   "Pull Requests"=>
    {"All"=>142,
     "Open"=>8,
     "Closed"=>134,
     "Open %"=>5.63,
     "Closed %"=>94.37,
     "Open/Closed % ratio"=>0.06,
     "Open time in days"=>804,
     "Min open time in days"=>6,
     "Max open time in days"=>390,
     "Average days request is opened"=>100,
     "Health"=>"Good"}}}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
