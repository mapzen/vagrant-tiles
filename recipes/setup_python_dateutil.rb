include_recipe 'python'
include_recipe "python::pip"

python_pip "python-dateutil" do
    action :install
end
