# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

name 'web-server'
default_source :chef_server, 'https://automate.cl/organizations/first-org'
default_source :supermarket
run_list 'bootstrap_a_node::default', 'chef-client::default', 'nginx_setup::default'
cookbook 'bootstrap_a_node'
cookbook 'chef-client', '~> 12.3.3', :supermarket
cookbook 'nginx_setup', '1.0.0', git: 'git@github.com:first-org-chef-repo/nginx_setup-cookbook.git', tag: 'v1.1'
# cookbook 'nginx_setup', '2.0.0', git: 'git@github.com:first-org-chef-repo/nginx_setup-cookbook.git', tag: 'v2.0'

##########
# Attributes
##########

# Specify CCR interval and splay
override['chef_client']['interval'] = 43200 # 12H
override['chef_client']['splay'] = 21600 # 6H

# Specify Policy name & Policy group
override['bootstrap_a_node']['policy_name'] = 'web-server'
override['bootstrap_a_node']['policy_group'] = 'production'

# Specify chef-client version
override['bootstrap_a_node']['chef_client']['version'] = '16.10'

# Disable Slack Notification that's set only for the initial CCR
override['chef_client']['handler']['slack']['enabled'] = false
# Specify node Time Zone
override['bootstrap_a_node']['timezone'] = 'Asia/Tokyo'
