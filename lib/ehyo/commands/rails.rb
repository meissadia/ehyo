group = 'Rails:'

command :'rails remi' do |c|
  c.syntax      = 'ehyo remi [options]'
  c.summary     = "#{group} Migrate DB from Version 0"
  c.description = 'Remigrate DB, Reseed DB, Start Server'

  c.option '--xseed',    'Skip db seeding'
  c.option '--xserver',  'Skip starting rails server'
  c.option '--xmigrate', 'Skip starting rails server'

  c.action do |args, options|
    puts `#{RAKE_MIGRATE_0}` if options.xmigrate.nil?
    puts `#{RAKE_MIGRATE}`   if options.xmigrate.nil?
    puts `#{RAKE_SEED}`      if options.xseed.nil?
    exec RAILS_SERVER        if options.xserver.nil?
  end
end
alias_command :'r:remi', :'rails remi'

command :'rails reset' do |c|
  c.syntax      = 'ehyo rails reset'
  c.summary     = "#{group} Recreate DB"
  c.description = 'Drop DB, Create DB, Seed DB, Start Server'

  c.action do |args, options|
    puts `rake db:drop`
    puts `rake db:create`
    puts `rake db:migrate`
    puts `rake db:seed`
  end
end
alias_command :'r:reset', :'rails reset'

command :'railsb' do |c|
  c.syntax      = 'ehyo railsb <app-name> [options]'
  c.summary     = "#{group} Start Background Server"
  c.description = 'Start Rails server in daemon mode.'

  c.option '--port STRING', String, 'Server listening port'

  c.action do |args, options|
    cmd = rails_dir_path(args.first)
    cmd = cmd.empty? ?
          rails_sbg(options.port) :              # Start app from current dir
          cmd + ' && ' + rails_sbg(options.port) # Jump to dir and start app
    `#{cmd}`
  end
end

command :'railsk' do |c|
  c.syntax      = 'ehyo railsk <app-name>'
  c.summary     = "#{group} Stop Background Server"
  c.description = 'Stop Background Rails Server'

  c.action do |args, options|
    cmd = rails_dir_path(args.first)
    cmd = cmd.empty? ?
          rails_kill(args) :              # Kill app in current dir
          cmd + ' && ' + rails_kill(args) # Jump to dir and kill app
    puts `#{cmd}`
  end
end

def rails_dir_path(dname)
  return '' if dname.nil? || dname.empty?
  "cd #{PATH_RAILS}#{dname}"
end

# Rails Server: Start in Background
def rails_sbg(port=nil)
  "#{RAILS_SERVER}#{' -p ' + port if port} -d"
end

def rails_kill(args)
  error   = "echo 'No running server found!'"
  success = "echo 'Server halted!'"
  file = args.empty? ?
    FILE_RAILS_PID :
    File.expand_path("#{PATH_RAILS}#{args.first}/#{FILE_RAILS_PID}")
  return "kill -9 $(cat #{file}) && #{success}" if File.exist?(file)
  error

end
