#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "/tmp/hadoop-1.0.4.tar.gz" do
  source "hadoop-1.0.4.tar.gz"
  mode 0600
  owner "root"
  group "admin"
end

execute "uncompress hadoop" do
  user "root"
  group "admin"
  cwd "/usr/local/apps"
  command "tar xfz /tmp/hadoop-1.0.4.tar.gz"
  action :run
end

execute "rename hadoop directory" do
  user "root"
  group "admin"
  cwd "/usr/local/apps"
  command "mv hadoop-1.0.4 hadoop"
end

execute "changing owner" do
  user "root"
  group "admin"
  cwd "/usr/local/apps"
  command "chown -R hduser:hadoop hadoop"
end

package "lzop" do
  action :install 
end

cookbook_file "/etc/profile.d/hadoop.sh" do
  source "hadoop.sh"
  mode 0644
  owner "root"
  group "admin"
end