require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class Feature
      class Finish < RGitFlow::Tasks::Task
        def initialize(git)
          super(git, 'finish', 'Finish a release branch', ['rgitflow', 'release'])
        end

        protected

        def run
          status 'Finishing release branch...'

          branch = @git.current_branch

          unless branch.start_with? RGitFlow::Config.options[:release]
            error 'Cannot finish a release branch unless you are in a release branch'
            abort
          end

          @git.branch(RGitFlow::Config.options[:master]).checkout
          @git.merge branch

          @git.push
          @git.push('origin', branch, {:delete => true})

          @git.branch(branch).delete

          status "Finished release branch #{branch}!"
        end
      end
    end
  end
end