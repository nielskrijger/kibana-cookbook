#
# Create directories
#

directories = [File.dirname(node['kibana']['nginx']['access_log']),
               File.dirname(node['kibana']['nginx']['error_log'])]
directories.each do |dir|
  directory dir do
    action :create
    recursive true
    owner node['kibana']['nginx']['user']
    group node['kibana']['nginx']['group']
    mode '0755'
  end
end

directories = [node['kibana']['dir']]
directories.each do |dir|
  directory dir do
    action :create
    recursive true
    owner node['kibana']['user']
    group node['kibana']['group']
    mode '0755'
  end
end

#
# Create user and group
#

group node['kibana']['group'] do
  system true
  gid node['kibana']['gid']
end

user node['kibana']['user'] do
  group node['kibana']['group']
  home node['kibana']['homedir']
  system true
  action :create
  manage_home true
  uid node['kibana']['uid']
end

#
# Installs Kibana in nginx data-directory
#

install_dir = Chef::Config[:file_cache_path]
ark 'kibana' do
  path install_dir
  url node['kibana']['url']
  version node['kibana']['version']
  action :put
end

bash 'move_kibana' do
  code <<-EOL
  mv #{install_dir}/kibana/* #{node['kibana']['dir']}
  chown -R #{node['kibana']['user']}:#{node['kibana']['group']} #{node['kibana']['dir']}/*
  EOL
end

#
# Set configuration
#

template node['kibana']['dir'] + '/config.js' do
  mode '0644'
  owner node['kibana']['user']
  group node['kibana']['group']
  source 'config.js.erb'
end

template node['kibana']['nginx']['config'] do
  mode '0644'
  owner 'root'
  group 'root'
  source 'nginx-kibana.conf.erb'
end

service 'nginx' do
  provider Chef::Provider::Service::Upstart
  action :restart
end