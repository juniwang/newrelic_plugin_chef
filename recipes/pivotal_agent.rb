# check required attributes
verify_attributes do
  attributes [
    'node[:newrelic][:plugin][:license]',
    'node[:newrelic][:plugin][:install_path]',
    'node[:newrelic][:pivotal_agent][:user]'
  ]
end

verify_license_key node[:newrelic][:plugin][:license]

include_recipe "rvm::system"

if node[:newrelic][:pivotal_agent][:rabbitmq_host] == "localhost"
  node.set[:newrelic][:pivotal_agent][:rabbitmq_host] = node['hostname']
end

install_plugin 'newrelic_pivotal_agent_ruby_plugin' do
  plugin_version   node[:newrelic][:pivotal_agent][:version]
  install_path     node[:newrelic][:plugin][:install_path]
  plugin_path      node[:newrelic][:pivotal_agent][:plugin_path]
  download_url     node[:newrelic][:pivotal_agent][:download_url]
  user             node[:newrelic][:pivotal_agent][:user]
end

# newrelic template
template "#{node[:newrelic][:pivotal_agent][:plugin_path]}/config/newrelic_plugin.yml" do
  source 'pivotal_agent/newrelic_plugin.yml.erb'
  action :create
  owner node[:newrelic][:pivotal_agent][:user]
  notifies :restart, 'service[newrelic-pivotal-agent-plugin]'
end

# install bundler gem and run 'bundle install'
bundle_install do
  path node[:newrelic][:pivotal_agent][:plugin_path]
  user node[:newrelic][:pivotal_agent][:user]
end

# install init.d script and start service
plugin_service 'newrelic-pivotal-agent-plugin' do
  daemon          './pivotal_agent'
  daemon_dir      node[:newrelic][:pivotal_agent][:plugin_path]
  plugin_name     'Newrelic Pivotal Agent Plugin'
  plugin_version  node[:newrelic][:pivotal_agent][:version]
  ruby_version    node['rvm']['default_ruby']
  run_command     "bundle exec"
end