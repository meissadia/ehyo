group = 'Git:'

command :'git aad' do |c|
  c.syntax      = 'ehyo aad [options]'
  c.summary     = "#{group} Add & Deploy"
  c.description = 'Add all changes to git. Prompt for commit message. Deploy to Github.'
  c.option '--message STRING', String, 'git commit message'
  c.option '--xpush', 'DON\'T push changes to Github'
  c.action do |args, options|
    puts "- #{c.summary} -" if c.summary
    msg = options.message || ask(COMMIT_MSG_PROMPT)
    if msg.empty?
      puts "User cancelation.\n\n"
      next
    end
    git_add_commit(msg)
    exec 'git push' unless options.xpush
  end
end
