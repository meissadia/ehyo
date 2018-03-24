# Rake
RAKE_SEED    = 'rake db:seed'
RAKE_MIGRATE = 'rake db:migrate'
RAKE_MIGRATE_0 = "#{RAKE_MIGRATE} VERSION=0"

# Rails
RAILS_SERVER = 'rails s -b 0.0.0.0'

# Heroku
HEROKU_RUN = 'heroku run'
PUSH_HEROKU = 'git push heroku master'

# Messages
COMMIT_MSG_PROMPT = 'Enter commit message ("Enter" to cancel): '

# Files
FILE_RAILS_PID = 'tmp/pids/server.pid'

# Directories
PATH_RAILS = '~/coding/rails/'

# Helper Methods
def git_add_commit(msg)
  puts `git add .`
  puts `git commit -m '#{msg}'`
end

def curl(url)
  Open3.popen3("curl #{url}") do |stdin, stdout, stderr, thread|
    stdout.read.chomp
  end
end
