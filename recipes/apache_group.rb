#
# Cookbook Name:: easy_dev
# Recipe:: apache_group
#

# gid of the group to which I want to add users (in our case: Developers group)
gid = node['easy_deploy']['gid']
users = node['etc']['passwd']
developers = Array.new

users.each do |id, details|
	if details["gid"] == gid
		developers << id
	end
end

group "apache" do
  members developers
  action :manage
end
