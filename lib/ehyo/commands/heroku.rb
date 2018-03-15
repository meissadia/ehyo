group = 'Heroku'
command :aad do |c|
  c.syntax      = 'ehyo aad [options]'
  c.summary     = "#{group}: Add & Deploy"
  c.description = 'Add all changes to git. Deploy to Heroku.'
  c.option '--message STRING', String, 'git commit message'
  c.option '--assets', 'Precompile rails assets'
  c.action do |args, options|
    puts "- #{c.summary} -" if c.summary
    puts `rake assets:precompile` if options.assets
    puts `git add .`
    msg = options.message || ask('Enter commit message: ')
    puts `git commit -m '#{msg}'`
    puts `git push heroku master`
  end
end

command :hredb do |c|
  c.syntax      = 'ehyo hredb [options]'
  c.summary     = "#{group}: Reset DB"
  c.description = 'Remigrate, Reseed DB, Restart Server'
  c.option '--no-seed',    'Skip db seeding'
  c.option '--no-migrate', 'Skip starting rails server'
  c.action do |args, options|
    puts `heroku run rake db:migrate VERSION=0` if options.no_migrate.nil?
    puts `heroku run rake db:migrate`           if options.no_migrate.nil?
    puts `heroku run rake db:seed`              if options.no_seed.nil?
  end
end

command :hpush do |c|
  c.syntax      = 'ehyo hpush'
  c.summary     = "#{group}: Push to Heroku"
  c.description = 'Push changes to Heroku'
  c.action do |args, options|
    puts `git push heroku master`
  end
end
