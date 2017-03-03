#!/usr/bin/env ruby
require 'foggy'
require 'pp'

# In order ot obtain a scoped (project and domain) token:
auth_v3 = {
  :url      => "http://localhost:5000",
  :user     => "admin",
  :password => "secret",
  :project  => "admin",
  :domain   => "default"
}

openstack = Misty::Cloud.new(:auth => auth_v3, :identity => {:base_path => ""})

cloud = Foggy::Cloud.new(openstack)

pp users = cloud.identity.users

nets = cloud.network.networks
first_network = nets[0]
pp first_network

pp cloud.network.networks.create(:network => {:name => "misty-example"})
