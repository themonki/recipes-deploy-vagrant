#
# Cookbook Name:: repositories
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
# 
# Documentation:
# https://twiki.grid.iu.edu/bin/view/Documentation/Release3/YumRpmBasics#Install_the_Yum_Repositories_req
#
execute "EPEL repository" do
  command "rpm -Uvh http://ftp-stud.hs-esslingen.de/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
  user "root"
  action :run
end

execute "yum-priorities" do
  command "yum -y install yum-priorities"
  user "root"
  action :run
end

execute "OSG repository" do
  command "rpm -Uvh http://repo.grid.iu.edu/osg-el6-release-latest.rpm"
  user "root"
  action :run
end

#
# http://www.globus.org/toolkit/docs/5.2/5.2.2/admin/install/#q-prereq
#
execute "Globus repository" do
  command "rpm -i http://www.globus.org/ftppub/gt5/5.2/stable/packages/rpm/centos/6/x86_64/Globus-repo-config.centos-6-1.noarch.rpm"
  user "root"
  action :run
end
