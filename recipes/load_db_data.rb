# this handles all the sides effects that set up the database initially

# need to figure out a way to make this all idempotent
# chef resource or definition that tries some sql and only executes the rest conditionally?

%w(postgis hstore postgis_topology).each do |extension|
  postgresql_database 'install postgis' do
    connection node[:pg][:conn_info]
    database_name 'gis'
    sql "create extension #{extension};"
    action :query
  end
end

bash 'run-osm2pgsql-to-import-data' do
  code <<-EOH
    export PGPASSWORD='#{node[:pg][:password]}'
    /usr/local/bin/osm2pgsql -U #{node[:pg][:user]} -d #{node[:pg][:dbname]} -H localhost --slim --hstore --cache 2048 --merc --prefix planet_osm --style #{node[:path]}/opt/vector-datasource/osm2pgsql.style --verbose --number-processes 1 #{node[:path]}/var/pbf/#{node[:pbf][:name]} 2>&1 >#{node[:path]}/var/log/osm2pgsql/osm-initial-import.log
  EOH
end

pgopts = "-U #{node[:pg][:user]} -d #{node[:pg][:dbname]} -h localhost"

bash 'import vector-datasource data' do
  code <<-EOH
    export PGPASSWORD='#{node[:pg][:password]}'
    for i in *.zip; do unzip $i; done
    ./shp2pgsql.sh | psql #{pgopts}
  EOH
  cwd "#{node[:path]}/opt/vector-datasource/data"
end

bash 'import additional data' do
  cwd "#{node[:path]}/tmp"
  code <<-EOH
    export PGPASSWORD='#{node[:pg][:password]}'

    wget http://data.openstreetmapdata.com/water-polygons-split-3857.zip
    unzip water-polygons-split-3857.zip
    shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom water-polygons-split-3857/water_polygons.shp water_polygons | psql #{pgopts}
    rm -rf ./water-polygons-split-3857 water-polygons-split-3857.zip

    wget http://data.openstreetmapdata.com/land-polygons-split-3857.zip
    unzip land-polygons-split-3857.zip
    shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom land-polygons-split-3857/land_polygons.shp land_polygons | psql #{pgopts}
    rm -rf ./land-polygons-split-3857 land-polygons-split-3857.zip

    wget http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip
    unzip simplified-land-polygons-complete-3857.zip
    shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom simplified-land-polygons-complete-3857/simplified_land_polygons.shp simplified_land_polygons | psql #{pgopts}
    rm -rf ./simplified-land-polygons-complete-3857 simplified-land-polygons-complete-3857.zip

  EOH
end

bash 'perform sql updates' do
  cwd "#{node[:path]}/opt/vector-datasource/data"
  code <<-EOH
    export PGPASSWORD='#{node[:pg][:password]}'
    ./perform-sql-updates.sh #{pgopts}
  EOH
end
