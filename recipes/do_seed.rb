bash 'seed tiles' do
  code "/usr/local/bin/tilequeue seed --config #{node[:path][:etc]}/tilequeue/config.yaml"
end
