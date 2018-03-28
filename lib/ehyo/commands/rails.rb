group = 'Rails:'

command :'rails redb' do |c|
  c.syntax      = 'ehyo redb [options]'
  c.summary     = "#{group} Reset DB"
  c.description = 'Remigrate DB, Reseed DB, Restart Server'
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
alias_command :'r:redb', :'rails redb'

command :'rails db:reset' do |c|
  c.syntax      = 'ehyo rails db:reset'
  c.summary     = "#{group} Reset DB"
  c.description = 'Remigrate DB, Reseed DB, Restart Server'
  c.action do |args, options|
    puts `rake db:drop`
    puts `rake db:create`
    puts `rake db:migrate`
    puts `rake db:seed`
  end
end
alias_command :'r:db:reset', :'rails db:reset'

command :'railsb' do |c|
  c.syntax      = 'ehyo railsb <app-name> [options]'
  c.summary     = "#{group} Start Background Server"
  c.description = 'Start Rails server in daemon mode.'
  c.option '--port STRING', String, 'Server listening port'
  c.action do |args, options|
    cmd = rails_path(args.first)
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
    cmd = rails_path(args.first)
    cmd = cmd.empty? ?
          rails_kill(args) :              # Kill app in current dir
          cmd + ' && ' + rails_kill(args) # Jump to dir and kill app
    puts `#{cmd}`
  end
end

def rails_path(dname)
  return '' if dname.nil? || dname.empty?
  "cd #{PATH_RAILS}#{dname}"
end

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
