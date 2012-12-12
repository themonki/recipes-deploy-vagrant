#
# Cookbook Name:: hduser
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
group "hadoop" do
end

user "hduser" do
  comment "Hadoop user"
  home "/home/hduser"
  gid "hadoop"
  shell "/bin/bash"
  password "$6$tc4xVTmZ$AHej1Oy9Bihu2riUe7UOgEMlwlm7m9VJPDAw928McuUoABhQBMyS.06olw0Phf3llku/v3GMWr8zpjqlPx4G4/"
  supports :manage_home => true
end

execute "ssh-keygen" do
  user "hduser"
  group "hadoop"
  cwd "/home/hduser"
  command "ssh-keygen -t rsa -N \"\" -f /home/hduser/.ssh/id_rsa"
  action :run
end

cookbook_file "/home/hduser/ssh.ext" do
  source "ssh.ext"
  owner "hduser"
  group "hadoop"
  mode 0755
end

execute "ssh first time" do
  user "hduser"
  group "hadoop"
  cwd "/home/hduser"
  command "./ssh.ext localhost hduser hduser"
end

execute "authorized hosts" do
  user "hduser"
  group "hadoop"
  cwd "/home/hduser"
  command "cat /home/hduser/.ssh/id_rsa.pub >> /home/hduser/.ssh/authorized_keys"
  action :run
end
