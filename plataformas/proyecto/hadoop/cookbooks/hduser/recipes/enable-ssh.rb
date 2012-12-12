cookbook_file "/home/hduser/ssh-copy-id.ext" do
  source "ssh-copy-id.ext"
  mode 0755
  owner "hduser"
  group "hadoop"
end

node[:hostconf][:slaves].each do |slave|
#["hadoopslave01", "hadoopslave02", "hadoopslave03", "hadoopmaster"].each do |slave|
  execute "enable ssh access" do
    user "hduser"
    group "hadoop"
    cwd "/home/hduser"
    command "./ssh-copy-id.ext #{slave} hduser hduser"
    action :run
  end
end
