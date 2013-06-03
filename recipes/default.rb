#
# Cookbook Name:: xinetd
# Recipe:: default
#
# Copyright 2011, Bryan W. Berry
#
# Apache 2.0
#

package "xinetd"

service "xinetd" do
  action [ :enable, :start ]
end

node.default_attrs['xinetd'].delete rescue nil
