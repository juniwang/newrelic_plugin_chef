default[:newrelic][:plugin][:install_path] = "/opt/newrelic"
default[:newrelic][:plugin][:license] = ""

# pivotal agent plugin attributes. Reference to:https://github.com/gopivotal/newrelic_pivotal_agent
default[:newrelic][:pivotal_agent][:plugin_path] = "#{node[:newrelic][:plugin][:install_path]}/newrelic_pivotal_agent_plugin"
default[:newrelic][:pivotal_agent][:version] = "1.0.5"
default[:newrelic][:pivotal_agent][:download_url] = "https://github.com/gopivotal/newrelic_pivotal_agent/archive/pivotal_agent-#{node[:newrelic][:pivotal_agent][:version]}.tar.gz"
default[:newrelic][:pivotal_agent][:user] = "root"
default[:newrelic][:pivotal_agent][:rabbitmq_host] = "localhost"
default[:newrelic][:pivotal_agent][:rabbitmq_port] = 15672
default[:newrelic][:pivotal_agent][:rabbitmq_user] = "guest"
default[:newrelic][:pivotal_agent][:rabbitmq_password] = "guest"
default[:newrelic][:pivotal_agent][:debug] = false


# logwatcher plugin attributes. Reference to https://github.com/railsware/newrelic_platform_plugins/
# check the tags for version list
default[:newrelic][:logwatcher][:plugin_path] = "#{node[:newrelic][:plugin][:install_path]}/logwatcher"
default[:newrelic][:logwatcher][:version] = "v1.0.0"
default[:newrelic][:logwatcher][:download_url] = "https://github.com/railsware/newrelic_platform_plugins/archive/#{node[:newrelic][:logwatcher][:version]}.tar.gz"
default[:newrelic][:logwatcher][:user] = "root"

# example of default[:newrelic][:logwatcher][:metrics]
#
# default_attributes({
#   "newrelic" => {
# 	  "logwatcher" => {
#       "metrics" => {
#         "tomcat" => { "log_path" => "/var/log/tomcat6/catalina.out", "term" => "[Ee]rror", "grep_options" => "v" },
#         "tomcat_access2" => { "log_path" => "/var/log/tomcat6/localhost_access_log.txt", "term" => "/contextpath/path" }
#       }
#     }
#   }
# })
default[:newrelic][:logwatcher][:metrics] = {}
