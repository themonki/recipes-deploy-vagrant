#
# Cookbook Name:: hostconf
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "/etc/hosts" do
  source "hosts"
  owner "root"
  group "root"
  mode 0644 
end

execute "hostname stop" do
  user "root"
  group "admin"
  cwd "/tmp"
  command "service hostname stop"
  returns 1
  action :run
end

template "/etc/hostname" do
  source "hostname.erb"
  mode 0644
  owner "root"
  group "root"
end

execute "hostname start" do
  user "root"
  group "admin"
  cwd "/tmp"
  command "service hostname start"
  action :run
end
  

