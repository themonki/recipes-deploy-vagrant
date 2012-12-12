#
# Cookbook Name:: hdfs
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# This snippet code was obtained from https://github.com/opscode-cookbooks/dynect/blob/master/recipes/ec2.rb#L48-55
#
ruby_block "modify hadoop-env.sh" do
  block do
    rc = Chef::Util::FileEdit.new("/usr/local/apps/hadoop/conf/hadoop-env.sh")
    rc.search_file_replace_line(/.*export JAVA.*/, "export JAVA_HOME=/usr/local/apps/jdk")
    rc.write_file
  end
end

directory "/app/hadoop/tmp" do
  owner "hduser"
  group "hadoop"
  mode "0755"
  recursive true
end

template "/usr/local/apps/hadoop/conf/core-site.xml" do
  source "core-site.erb"
  owner "hduser"
  group "hadoop"
  mode 0664
end

template "/usr/local/apps/hadoop/conf/mapred-site.xml" do
  source "mapred-site.erb"
  owner "hduser"
  group "hadoop"
  mode 0664
end

template "/usr/local/apps/hadoop/conf/hdfs-site.xml" do
  source "hdfs-site.erb"
  owner "hduser"
  group "hadoop"
  mode 0644
end

#execute "formatting - hdfs style" do
#  user "hduser"
#  group "hadoop"
#  cwd "/home/hduser"
#  command "/usr/local/apps/hadoop/bin/hadoop namenode -format"
#  action :run
#end