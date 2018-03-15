group = 'Git:'

def escape_quotes(str)
  str = str.gsub("'", "\\'")
  str.gsub('"', '\\"')
end

command :aac do |c|
  c.syntax      = 'ehyo aac [options]'
  c.summary     = "#{group} Add & Commit"
  c.description = 'Add all changes to git. Prompt for commit message.'
  c.option '--message STRING', String, 'git commit message'
  c.action do |args, options|
    puts "- #{c.summary} -" if c.summary
    puts `git add .`
    msg = options.message || ask('Enter commit message: ')
    puts `git commit -m '#{msg}'`
  end
end
