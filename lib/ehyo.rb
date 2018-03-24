require 'commander'
require 'open3'
require_relative "ehyo/version"
include Commander::Methods

module Ehyo
  class Cli
    def run
      program :name, 'Eh, Yo!'
      program :version, VERSION
      program :description, 'a system automation assistant'
      default_command :help

      # Available Commands
      require_relative 'ehyo/commands/shared'
      require_relative 'ehyo/commands/git'
      require_relative 'ehyo/commands/heroku'
      require_relative 'ehyo/commands/rails'
      require_relative 'ehyo/commands/shell'

      run! # Execute CLI
    end

  end
end
