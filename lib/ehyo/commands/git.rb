group = 'Git:'

command :'git aac' do |c|
  c.syntax      = 'ehyo aac [options]'
  c.summary     = "#{group} Add & Commit"
  c.description = 'Add all changes to git. Prompt for commit message.'
  c.option '--message STRING', String, 'git commit message'
  c.option '--push', 'push changes to REMOTE'
  c.action do |args, options|
    puts "- #{c.summary} -" if c.summary
    msg = options.message || ask(COMMIT_MSG_PROMPT)
    return if msg.empty?
    git_add_commit(msg)
    exec 'git push' if options.push
  end
end
