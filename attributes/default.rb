default['kibana']['user'] = 'kibana'
default['kibana']['uid'] = nil # set to nil to let system pick
default['kibana']['group'] = 'kibana'
default['kibana']['gid'] = nil # set to nil to let system pick
default['kibana']['homedir'] = '/home/kibana'
default['kibana']['version'] = '3.0.1'
default['kibana']['url'] = "https://download.elasticsearch.org/kibana/kibana/kibana-#{node['kibana']['version']}.tar.gz"
default['kibana']['dir'] = '/home/kibana/public_html'

default['kibana']['nginx']['config'] = '/etc/nginx/conf.d/kibana.conf'
default['kibana']['nginx']['user'] = 'nginx'
default['kibana']['nginx']['group'] = 'nginx'
default['kibana']['nginx']['http_port'] = 80
default['kibana']['nginx']['server_name'] = 'localhost'
default['kibana']['nginx']['elasticsearch_path'] = 'http://127.0.0.1:9200'
default['kibana']['nginx']['access_log'] = '/var/log/nginx/kibana/access.log'
default['kibana']['nginx']['error_log'] = '/var/log/nginx/kibana/error.log'

default['kibana']['config']['kibana_index'] = 'kibana-int'
default['kibana']['config']['panel_names'] = [
    'histogram', 'map', 'pie', 'table', 'filtering', 'timepicker', 'text', 'fields',
    'hits', 'dashcontrol', 'column', 'derivequeries', 'trends', 'bettermap', 'query', 'terms'
]
default['kibana']['config']['default_route'] = '/dashboard/file/logstash.json'
default['kibana']['config']['elasticsearch'] = "window.location.protocol+\"//\"+window.location.hostname+\":\"+window.location.port"