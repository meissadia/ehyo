require 'open3'
group = 'Shell:'
command :ip do |c|
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

private

def curl(url)
  Open3.popen3("curl #{url}") do |stdin, stdout, stderr, thread|
    stdout.read.chomp
  end
end
