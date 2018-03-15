require 'commander'
require_relative "ehyo/version"
include Commander::Methods

module Ehyo
  class Cli
    def run
      program :name, 'ehyo'
      program :version, VERSION
      program :description, 'Command Assistant'

      # Available Commands
      require_relative 'ehyo/commands/heroku'
      require_relative 'ehyo/commands/rails'
      require_relative 'ehyo/commands/shell'

      run! # Execute CLI
    end

  end
end
