#
# Cookbook Name:: newrelic_plugins
# Recipe:: logwatcher
#
# Copyright 2012-2014, Escape Studios
#

# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:plugin][:license]',
    'node[:newrelic][:plugin][:install_path]',
    'node[:newrelic][:logwatcher][:version]'
  ]
end

verify_license_key node[:newrelic][:plugin][:license]

include_recipe "rvm::system"

install_plugin 'logwatcher_ruby_plugin' do
  plugin_version   node[:newrelic][:logwatcher][:version]
  install_path     node[:newrelic][:plugin][:install_path]
  plugin_path      node[:newrelic][:logwatcher][:plugin_path]
  download_url     node[:newrelic][:logwatcher][:download_url]
  user             node[:newrelic][:logwatcher][:user]
end

logwatcher_plugin_path = "#{node[:newrelic][:logwatcher][:plugin_path]}/newrelic_logwatcher_agent"

# bash for daemon
template "#{logwatcher_plugin_path}/logwatcher" do
  source 'logwatcher/logwatcher.erb'
  action :create
  owner node[:newrelic][:logwatcher][:user]
  mode "0755"
  notifies :restart, 'service[newrelic-logwatcher-plugin]'
end

directory "#{logwatcher_plugin_path}/config" do
	action :create
	recursive true
	owner params[:user]
end

# newrelic template
template "#{logwatcher_plugin_path}/config/newrelic_plugin.yml" do
  source 'logwatcher/newrelic_plugin.yml.erb'
  action :create
  owner node[:newrelic][:logwatcher][:user]
  notifies :restart, 'service[newrelic-logwatcher-plugin]'
end

# install bundler gem and run 'bundle install'
bundle_install do
  path "#{logwatcher_plugin_path}"
  user node[:newrelic][:logwatcher][:user]
end

# install init.d script and start service
plugin_service 'newrelic-logwatcher-plugin' do
  daemon          './logwatcher'
  daemon_dir      logwatcher_plugin_path
  plugin_name     'Newrelic LogWatcher Plugin'
  plugin_version  node[:newrelic][:logwatcher][:version]
  ruby_version    node['rvm']['default_ruby']
  run_command     "bundle exec"
end