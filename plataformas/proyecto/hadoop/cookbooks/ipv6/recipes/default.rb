#
# Cookbook Name:: ipv6
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "/tmp/ipv6-disabler" do
  source "ipv6-disabler"
  mode 0600
  owner "root"
  group "admin"
end

execute "disabling ipv6" do
  user "root"
  group "admin"
  cwd "/tmp"
  command "cat ipv6-disabler >> /etc/sysctl.conf"
  action :run
end