unless File.exists?("#{node[:path][:var]}/did_setup_database")

  include_recipe 'mapzen_localtiles::create_database'

  include_recipe 'mapzen_localtiles::download_pbf'

  # load_db_data is not idempotent
  include_recipe 'mapzen_localtiles::load_db_data'

  # create file to prevent setting up database on future runs
  file "#{node[:path][:var]}/did_setup_database" do
    action :touch
  end

end
