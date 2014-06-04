#
# Cookbook Name:: pylern2
# Recipe:: default
#
# Copyright 2014, Maruya Yoshihisa
#
# All rights reserved - Do Not Redistribute

include_recipe "python"
include_recipe "apt"
include_recipe "git"

package "python-numpy" do
    action :install
end

package "python-scipy" do
    action :install
end

package "python-setuptools" do
    action :install
end

package "python-matplotlib" do
    action :install
end

template "/etc/profile.d/pylern2_env.sh" do
    mode 0755
    source "pylern2_env.sh.erb"
    variables(:pylern2_home => node[:pylern2][:install_path] + "/pylearn2/scripts",
              :pylern2_data_path => node[:pylern2][:data_path])
end

#you must run only once
python_pip "git+git://github.com/Theano/Theano.git" do
    action :install
    options "--upgrade --no-deps"
end

bash "install_pylern2" do
    user "root"
    cwd "/tmp"
    code <<-EOH
    mkdir -p #{node[:pylern2][:data_path]}
    chmod 777 #{node[:pylern2][:data_path]}
    git clone git://github.com/lisa-lab/pylearn2.git #{node[:pylern2][:install_path]}
    chmod 755 #{node[:pylern2][:install_path]}
    cd #{node[:pylern2][:install_path]}
    python setup.py develop
    EOH
end

