#
# Cookbook Name:: easy_dev
# Recipe:: apache_group
#

# gid of the group to which I want to add users 
#   see attributes (in our case: Developers group)
gid = node['easy_dev']['gid']

users = node['etc']['passwd']
groups = node['etc']['group']

# list of users that need to be added to apache group
developers = Array.new

# adding users that have the group as default group
users.each do |id, user_details|
	if user_details["gid"] == gid
		developers << id
	end
end

# adding users that have the group as secondary group
groups.each do |grp, grp_details|
	if grp_details["gid"] == gid
		developers << grp_details["members"]
	end
end

# modify the apache group on the node
group "apache" do
  members developers
  action :manage
end
