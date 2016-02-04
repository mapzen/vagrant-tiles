file '/etc/init.d/tileinit' do
    mode '0744'
    owner 'root'
    group 'root'
    content <<-EOF
#!/bin/bash
mkdir /run/tileserver
chmod 0777 /run/tileserver

mkdir /run/tilequeue
chmod 0777 /run/tilequeue

mkdir /run/osm2pgsql
chmod 0777 /run/osm2pgsql
    EOF
end

bash 'install tileinit service' do
    code 'update-rc.d tileinit defaults 10'
end
