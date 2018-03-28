group = 'Gem:'

command :'gem:install' do |c|
  c.syntax      = 'ehyo gem'
  c.summary     = "#{group} Build & Install"
  c.description = 'Build and install the current directory\'s gem'
  c.action do |args, options|
    ext = '.gemspec'
    spec = `ls *#{ext} | head`
    puts `gem build #{spec}`
    puts `gem install #{File.basename(spec, File.extname(spec))}`
  end
end
