#
# Cookbook Name:: osgcacerts
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# https://twiki.grid.iu.edu/bin/view/Documentation/Release3/YumRpmBasics#Installation
#
execute "osg-ca-certs" do
  command "yum -y install osg-ca-certs"
  user "root"
  action :run  
end