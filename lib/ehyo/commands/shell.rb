group = 'Shell:'

command :'my ip' do |c|
  c.syntax      = 'ehyo myip'
  c.summary     = "#{group} Display IP Addresses"
  c.description = 'Display Local and External IP Addresses'

  c.action do |args, options|
    puts
    puts 'Local   : ' + `ipconfig getifaddr en1`
    puts 'External: ' + curl("http://ipecho.net/plain")
    puts
  end
end

command :'find ps' do |c|
  c.syntax      = 'ehyo find ps <term>'
  c.summary     = "#{group} ps aux | grep <term>"
  c.description = 'Search running processes.'
  
  c.action do |args, options|
    puts `ps aux | grep #{args.join ' '}`
  end
end
