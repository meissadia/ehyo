require 'open3'

command :ip do |c|
  c.syntax      = 'ehyo myip'
  c.summary     = 'Display IP Addresses'
  c.description = 'Display Local and External IP Addresses'
  c.action do |args, options|
    puts
    puts 'Local   : ' + `ipconfig getifaddr en1`
    Open3.popen3("curl http://ipecho.net/plain") do |stdin, stdout, stderr, thread|
       puts 'External: ' + stdout.read.chomp
    end
    puts
  end
end
