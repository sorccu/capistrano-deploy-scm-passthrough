require 'capistrano/recipes/deploy/scm/base'

module Capistrano
  module Deploy
    module SCM

      # An SCM even more trivial than :none. The basic idea is that everything
      # is simply passed through. In general it's a bad idea to use it unless
      # you've got something else such as Jenkins managing the real SCM.
      #
      # Note that strategies that expect files being copied don't work with
      # the :passthrough SCM. Namely, :copy does not work.
      class Passthrough < Base
        # Satisfy dependency checks.
        default_command 'true'

        # No versioning, thus, no head. Returns the empty string.
        def head
          ''
        end

        # Return a command that always succeeds and has no side effects.
        # Whatever we are given we're just going to pass through.
        def sync(revision, destination)
          'true'
        end

        alias_method :checkout, :sync
        alias_method :export, :checkout

        # No versioning, so this just returns the argument, with no
        # modification.
        def query_revision(revision)
          revision
        end

        def log(from="", to="")
          "#{self.class.name}: #{from} - #{to}"
        end

      end

    end
  end
end
