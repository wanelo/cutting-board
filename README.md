Cutting Board
=============

cutting-board is a chef and capistrano plugin that assists deployment by
bridging the two. Using knife search, cutting-board will create local caches
of server lists in yml format, which capistrano can then use during deployment.

cutting-board supports:
* capistrano multi-stage deployments
* multiple knife configuration files to differentiate deployment stages

cutting-board assumes:
* you are using capistrano/ext/multistage


## Usage

Add cutting-board to your Gemfile:
```ruby
gem 'cutting-board'
```

The first step is to generate cutting-board configuration files:
```bash
cutting-board init
```

This will create three files,
```yml
/path/to/project/
  - .cutting-board
  - .cutting-board-cache
  - .cutting-board-mapping
```

cutting-board writes out its configuration files in the root of 
your application. In many cases, you will want to gitignore its 
main configuration file. The gem saves the local path to knife 
configuration files, which may be different on different
workstations (does every developer check out work projects to 
exactly the same path? hint: no).
```bash
# .gitignore
.cutting-board
```

The mapping of capistrano roles to chef roles will likely be 
checked into source control, as well as the cache of server IPs.


### Configuration

In order to use cutting-board, you must first map capistrano 
stages to knife configuration files.

If you are using the same knife.rb for all stages of your 
capistrano deployment, you can do the following:
```bash
cutting-board knife config all </path/to/knife.rb>
```

If you are using different knife.rb files for different capistrano 
stages, you can do the following:
```bash
cutting-board knife config <stage> </path/to/knife.rb>
...
cutting-board knife config production ~/workspace/chef/.chef/knife.rb
cutting-board knife config staging ~/workspace/chef/.chef/knife-staging.rb
```

The mapping of capistrano roles to chef roles is done in 
`.cutting-board-mapping`. This file takes the following yml formats:
```yml
capistrano_role: chef_search
```

For example:
```yml
load_balancer: "role:load-balancer"
app_server: "role:app-server"
queue_server: "role:sidekiq*"
```

This can be overridden on a per-stage bases as follows:
```yml
app_server: "role:app-server"
stages:
  admin:
    app_server: "role:admin-app-server"
```


### Creating local cache

To generate the server cache, run the following command:
```bash
cutting-board cache update <stage>
```


### Configuring Capistrano

A "normal" capistrano stage file will look something like this:
```ruby
role :app, '10.0.0.1', '10.0.0.2'
role :db, '10.0.0.1', primary: true
```

Using cutting-board, you will change your stage file to the following:
```ruby
require 'capistrano/cutting-board'
role_from_chef :app, :app_servers
role_from_chef :db, :app_servers, limit: 1, primary: true
```

Deploy all the things!


## Contributions

Contributions and bug fixes are welcome! Please include tests and follow the
general format of the existing code.

* hash syntax should follow ruby 1.9.3 notation, ie: { a: "b" }
  * except where keys are strings. try not to use string keys.
* pull requests will not be accepted without accompanying tests

## License

The MIT License (MIT)

Copyright (c) 2013 Wanelo, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
