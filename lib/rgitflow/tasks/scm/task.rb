require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class SCM
      class Task < RGitFlow::Tasks::Task
        def initialize(git, name, description, namespaces=['rgitflow', 'scm'],
                       dependencies=[])
          super(git, name, description, namespaces, dependencies)
        end

        def dirty?
          @git.diff.size > 0
        end

        def print_status
          added    = []
          modified = []
          deleted  = []

          @git.diff.each { |f|
            if f.type == 'new'
              added << f
            elsif f.type == 'modified'
              modified << f
            elsif f.type == 'deleted'
              deleted << f
            end
          }

          debug 'added'
          added.each { |f|
            debug "  #{ANSI::Constants::GREEN}#{ANSI::Constants::BRIGHT}"\
                  "#{f.path}#{ANSI::Constants::CLEAR}"
          }

          debug 'modified'
          modified.each { |f|
            debug "  #{ANSI::Constants::YELLOW}#{ANSI::Constants::BRIGHT}"\
                  "#{f.path}#{ANSI::Constants::CLEAR}"
          }

          debug 'deleted'
          deleted.each { |f|
            debug "  #{ANSI::Constants::RED}#{ANSI::Constants::BRIGHT}"\
                  "#{f.path}#{ANSI::Constants::CLEAR}"
          }
        end
      end
    end
  end
end
