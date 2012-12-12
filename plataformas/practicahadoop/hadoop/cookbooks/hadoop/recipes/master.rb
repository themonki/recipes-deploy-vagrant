template "/usr/local/apps/hadoop/conf/masters" do
  source "masters.erb"
  owner "hduser"
  group "hadoop"
  mode 0664
end

template "/usr/local/apps/hadoop/conf/slaves" do
  source "slaves.erb"
  owner "hduser"
  group "hadoop"
  mode 0664
end