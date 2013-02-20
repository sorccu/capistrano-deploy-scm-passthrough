# capistrano-deploy-scm-passthrough

## Overview

**capistrano-deploy-scm-passthrough** provides a simple passthrough SCM implementation for [Capistrano](https://github.com/capistrano/capistrano). This differs from the built-in `:none` SCM in the following ways:

* It uses your local files directly (i.e. a checkout is essentially a no-op). The `:none` SCM recursively copies the current folder to a temp directory.
* It can be used with remote strategies, such as [capistrano_rsync_with_remote_cache](https://github.com/vigetlabs/capistrano_rsync_with_remote_cache).
* **CAUTION:** the `:passthrough` SCM cannot be used with the `:copy` strategy, or any other strategy that relies on files being actually copied around.

You'll see the most benefit if you happen to be working with a large and/or binary-heavy repository deployed by a CI server. In fact it's a bad idea to use this gem if you are running the deploy command locally.

## Installation

Simply install the gem and you're done:

    gem install capistrano-deploy-scm-passthrough

No other setup is needed.

## Usage

Set your `:scm` as follows:

    set :scm, :passthrough
    set :repository, '.'

For a sligtly more complicated example (and perhaps to understand why this gem was made), consider a case where Capistrano is run by a CI server such as [Jenkins](http://jenkins-ci.org/). Jenkins will deal with the SCM, so there is no need for Capistrano to complicate things:

**deploy.rb**

    # Jenkins manages the SCM.
    set :scm, :passthrough
    set :repository, '.'
    set :revision, ENV['GIT_COMMIT'] || ENV['SVN_REVISION'] || Time.now

We are also using Jenkins' environment variables to set the `:revision` property, which will be written into Capistrano's REVISION file. This is not 100% necessary, but is good to have so that you can check what you have deployed if necessary.

The `:passthrough` strategy works especially well with [capistrano_rsync_with_remote_cache](https://github.com/vigetlabs/capistrano_rsync_with_remote_cache), allowing for quick deploys even with binary-heavy repositories. An example configuration might be:

**deploy.rb**

    # Deploy configuration for the rsync_with_remote_cache strategy.
    set :deploy_via, :rsync_with_remote_cache
    set :rsync_options, '-azF --delete --delete-excluded'
    set :local_cache, '.'

Note that we have set the `-F` option, which looks for include/exclude patterns in an `.rsync-filter` file. The following example works for a case where you'd only like to deploy the contents of a single folder (say, `public`) with the REVISION file, with everything else (including nested `.svn` folders) ignored.

**.rsync-filter**

    - .svn
    + public/***
    + REVISION
    - *

## License

Copyright (c) 2013 Simo Kinnunen

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.