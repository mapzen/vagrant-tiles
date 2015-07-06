postgresql_database_user node[:pg][:user] do
  connection node[:pg][:conn_info]
  password node[:pg][:password]
  action :create
end

postgresql_database node[:pg][:dbname] do
  connection node[:pg][:conn_info]
  owner node[:pg][:user]
  action :create
end

postgresql_database_user node[:pg][:user] do
  connection node[:pg][:conn_info]
  database_name node[:pg][:dbname]
  privileges [:all]
  action :grant
end
