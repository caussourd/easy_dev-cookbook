#
# Cookbook Name:: easy_dev
# Recipe:: apache_group
#

# gid of the group to which I want to add users 
# See attributes (in our case: Developers group)
gid = node['easy_dev']['gid']

users = node['etc']['passwd']
groups = node['etc']['group']

# list of users that need to be added to apache group
developers = []

# adding users that have the group as default group
users.each do |id, user_details|
  if user_details['gid'] == gid
    developers << id
  end
end

# adding users that have the group as secondary group
groups.each do |grp, grp_details|
  if grp_details['gid'] == gid
    developers << grp_details['members']
  end
end

# we set the name of the apache group depending on the platform
apache_group_name = 
  if (node['platform'] == 'ubuntu') || (node['platform'] == 'debian')
    'www-data'
  else
    'apache'
  end

# modify the apache group on the node
group apache_group_name do
  members developers
  action :manage
end
