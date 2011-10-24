#
# Cookbook Name:: xinetd
# Recipe:: default
#
# Copyright 2011, Bryan W. Berry
#
# Apache 2.0
#

package "xinetd" do
	action :install
end

service "xinetd" do
	action [:enable,:start]
end
