default[:pg][:dbname] = 'gis'
default[:pg][:user] = 'gisuser'
default[:pg][:password] = node['postgresql']['password']['postgres']

default[:pg][:conn_info] = {
  :host => "127.0.0.1",
  :port => 5432,
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

default[:git][:vector_datasource][:url] = 'https://github.com/mapzen/vector-datasource.git'
default[:git][:vector_datasource][:branch] = 'master'
