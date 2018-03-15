group = 'Rails'
command :redb do |c|
  c.syntax      = 'ehyo redb [options]'
  c.summary     = "#{group}: Reset DB"
  c.description = 'Remigrate, Reseed DB, Restart Server'
  c.option '--no-seed',    'Skip db seeding'
  c.option '--no-server',  'Skip starting rails server'
  c.option '--no-migrate', 'Skip starting rails server'
  c.action do |args, options|
    puts `rake db:migrate VERSION=0` if options.no_migrate.nil?
    puts `rake db:migrate`           if options.no_migrate.nil?
    puts `rake db:seed`              if options.no_seed.nil?
    exec 'rails s -b 0.0.0.0'        if options.no_server.nil?
  end
end

command :server do |c|
  c.syntax      = 'ehyo rails_s'
  c.summary     = 'Rails: Server'
  c.description = 'Start externally accessible server'
  c.action do |args, options|
    exec 'rails s -b 0.0.0.0'
  end
end
