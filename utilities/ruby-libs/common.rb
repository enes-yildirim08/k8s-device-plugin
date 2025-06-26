def get_github_user
  github_user = "#{ENV['GITHUB_USER']}"

  if github_user.nil? or github_user.empty?
    puts "Please export GITHUB_USER environment variable for the user".red
    exit!
  end

  github_user
end

def check_plugins
  Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    missingPlugins = Array.new
  
    # Required Plugin warnings 
    [
      { :name => "vagrant-virtual-hostsupdater", :version => "1.4.0" },
    ].each do |plugin|
      unless Vagrant.has_plugin?(plugin[:name], plugin[:version])
        missingPlugins.push "vagrant plugin install #{plugin[:name]} --plugin-version=#{plugin[:version]}"
      end
    end
    
    if not missingPlugins.empty?
      puts "Missing plugins. Please install them."
  
      missingPlugins.each do |missingPlugin|
        puts "  #{missingPlugin}"
      end
  
      exit!
    end
  end
end
