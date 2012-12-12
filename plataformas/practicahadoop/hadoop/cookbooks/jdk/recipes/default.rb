#
# Cookbook Name:: jdk
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "/tmp/jdk-7u3-linux-x64.tar.gz" do
  source "jdk-7u3-linux-x64.tar.gz"
  mode 0600
  owner "root"
  group "admin"
end

directory "/usr/local/apps" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

execute "uncompress jdk" do
  user "root"
  group "admin"
  cwd "/usr/local/apps"
  command "tar xfz /tmp/jdk-7u3-linux-x64.tar.gz"
  action :run
end

execute "symbolic link to jdk" do
  user "root"
  group "admin"
  cwd "/usr/local/apps"
  command "ln -sf jdk1.7.0_03 jdk"
  action :run
end

cookbook_file "/etc/profile.d/jdk.sh" do
  source "jdk.sh"
  mode 0644
  owner "root"
  group "admin"
end
