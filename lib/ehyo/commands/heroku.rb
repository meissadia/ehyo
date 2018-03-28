group = 'Heroku:'
command :'heroku aad' do |c|
  c.syntax      = 'ehyo heroku aad [options]'
  c.summary     = "#{group} Add & Deploy"
  c.description = 'Add all changes to git. Deploy to Heroku.'
  c.option '--message STRING', String, 'git commit message'
  c.option '--precomp', 'Precompile rails assets'
  c.action do |args, options|
    puts "- #{c.summary} -" if c.summary
    msg = options.message || ask(COMMIT_MSG_PROMPT)
    if msg.empty?
      puts "User canceled deployment.\n\n"
      next
    end
    puts `rake assets:precompile` if options.precomp
    git_add_commit(msg)
    puts `#{PUSH_HEROKU}`
  end
end
alias_command :'h:aad', :'heroku aad'

command :'heroku redb' do |c|
  c.syntax      = 'ehyo hredb [options]'
  c.summary     = "#{group} Reset DB"
  c.description = 'Remigrate, Reseed DB, Restart Server'
  c.option '--no-seed',    'Skip db seeding'
  c.option '--no-migrate', 'Skip starting rails server'
  c.action do |args, options|
    puts `#{HEROKU_RUN} #{RAKE_MIGRATE_0}` if options.no_migrate.nil?
    puts `#{HEROKU_RUN} #{RAKE_MIGRATE}`   if options.no_migrate.nil?
    puts `#{HEROKU_RUN} #{RAKE_SEED}`      if options.no_seed.nil?
  end
end
alias_command :'h:redb', :'heroku redb'

command :'heroku push' do |c|
  c.syntax      = 'ehyo hpush'
  c.summary     = "#{group} Push to Heroku"
  c.description = 'Push changes to Heroku'
  c.action do |args, options|
    puts `#{PUSH_HEROKU}`
  end
end
alias_command :'h:push', :'heroku push'
