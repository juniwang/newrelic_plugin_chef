## New Relic Plugin's Cookbook ##

## Overview ##

This cookbook installs, configures and manages as a service New Relic Plugins on Debian/RHEL.

To use the cookbook, add it to your Chef cookbooks path under the name `newrelic_plugins`.

Recipes for the following plugins are provided:

 - [logwatcher](logwatcher plugin)
 - [pivotal_agent](#RabbitMQ-monitoring-plugin)

## Requirements ##

Chef 0.10.10+ and Ohai 6.10+ for `platform_family` support.

- Ruby >= 1.9.3 
- Rubygems >= 1.9

## Platforms ##
 - CentOS
 - Red Hat

## Pivotal Agent Plugin ##

#### Attributes: ####
 
 `node[:newrelic][:plugin][:license]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:plugin][:install_path]` -  _(required)_ Install directory. Defaults to `/opt/newrelic`. Any downloaded files will be placed here. The plugin will be installed within this directory at `pivotal_agent`. 
 
 `node[:newrelic][:pivotal_agent][:version]` - _(required)_ Version of the plugin
 
 `node[:newrelic][:pivotal_agent][:rabbitmq_host]` -  _(optional)_ RabbitMQ host to monitor. `localhost` by default.
 
 `node[:newrelic][:pivotal_agent][:rabbitmq_port]` -  _(optional)_ RabbitMQ management API port. 15672 by default.
 
 `node[:newrelic][:pivotal_agent][:rabbitmq_user]` -  _(required)_ RabbitMQ management API user. `guest` by default.
 
 `node[:newrelic][:pivotal_agent][:rabbitmq_password]` - _(required)_ RabbitMQ management API password. `guest` by default.

 `node[:newrelic][:pivotal_agent][:debug]` - _(optional)_ debug model. You will get more logs in debug model.

#### Usage: ####

    name "newrelic_plugins"
    description "System that run New Relic plugins"
    run_list(
      "recipe[newrelic_plugins::pivotal_agent]"
    )
    default_attributes(
      "newrelic" => {
        "plugin" => { 
          "license" => "NEW_RELIC_LICENSE_KEY"
        },
        "pivotal_agent" => {
          "rabbitmq_host" => "localhost",
          "rabbitmq_port" => "15672",
          "rabbitmq_user" => "guest",
          "rabbitmq_password" => "guest"
        }
      }
    )

For additional info, see https://github.com/gopivotal/newrelic_pivotal_agent

## Log Watcher Plugin ##

#### Attributes: ####

 `node[:newrelic][:plugin][:license]` - _(required)_ New Relic License Key
 
 `node[:newrelic][:logwatcher][:version]` -  _(required)_ version of the plugin to install.
 
 `node[:newrelic][:logwatcher][:metrics]` - _(required)_ metrics to watch. Each metric consists of a full path of the log file, a regex of term to grep and an optional grep options.
 
#### Usage: ####

    name "newrelic_plugins"
    description "System that run New Relic plugins"
    run_list(
      "recipe[newrelic_plugins::logwatcher]"
    )
    default_attributes(
      "newrelic" => {
        "plugin" => { 
          "license" => "NEW_RELIC_LICENSE_KEY"
        },
        "logwatcher" => {
          "metrics" => {
            "tomcat" => { "log_path" => "/var/log/tomcat6/catalina.out", "term" => "[Ee]rror", "grep_options" => "v" },
            "tomcat_access2" => { "log_path" => "/var/log/tomcat6/localhost_access_log.txt", "term" => "/contextpath/path" }
          }
        }
      }
    )

For additional info, see https://github.com/railsware/newrelic_platform_plugins

## License ##

This cookbook is under the included MIT License.

## Contact ##

Contribute to this Cookbook at https://github.com/wangjunbo924/newrelic_plugins_chef. Any other feedback or support related questions can be sent to support @ newrelic.com. 