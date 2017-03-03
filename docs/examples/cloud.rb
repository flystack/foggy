#!/usr/bin/env ruby
require 'foggy'

# In order ot obtain a scoped (project and domain) token:
auth_v3 = {
  :url      => "http://localhost:5000",
  :user     => "admin",
  :password => "secret",
  :project  => "admin",
  :domain   => "default"
}

cloud = Foggy::Cloud.new(:auth => auth_v3)

users = cloud.identity.users
networks = cloud.networking.networks
p networks.all
p networks[0]
p networks[0].id
p networks[0].name
networks.reload

network = cloud.networking.networks.get("f3180183-9e7a-42d7-b76a-23b2c95af121")
network.name="new name"

subnets = cloud.networking.subnets.all
