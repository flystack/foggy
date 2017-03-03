# Introduction

Foggy is providing Collections for Openstack.
Foggy is using Misty for Openstack APIs conduit.


```ruby
require 'foggy'

auth = {
  :url      => "http://192.0.2.21:5000",
  :user     => "admin",
  :password => "secret",
  :project  => "admin",
  :domain   => "default"
}

cloud = Foggy::Cloud.new(:auth => auth)
```

```
pry(main)> cloud.networking.class
=> Foggy::Networking
```

```
pry(main)> cloud.networking.networks.class
=> Foggy::Networking::Networks
```

```
pry(main)> networks = cloud.networking.networks.all
=> [#<Foggy::Networking::Networks::Network:0x007faa5718f2a0
  @admin_state_up=true,
  @availability_zone_hints=[],
  @availability_zones=[],
  @created_at="2016-11-14T04:23:49",
  @description="",
  @id="67ef2b90-6217-4c0d-a022-80e48f7f60e6",
  @ipv4_address_scope=nil,
  @ipv6_address_scope=nil,
  @is_default=false,
  @mtu=1450,
  @name="Test2",
  @port_security_enabled=true,
  @provider={"physical_network"=>nil, "segmentation_id"=>69, "network_type"=>"vxlan"},
  @qos_policy_id=nil,
  @router={"external"=>true},
  @shared=false,
  @status="ACTIVE",
  @subnets=[],
  @tags=[],
  @tenant_id="48985e6b8da145699d411f12a3459fca",
  @updated_at="2016-11-14T04:23:49">,
 #<Foggy::Networking::Networks::Network:0x007faa5718ab38
  @admin_state_up=true,
  @availability_zone_hints=[],
  @availability_zones=["nova"],
  @created_at="2016-11-14T04:06:39",
  @description="",
  @id="f3180183-9e7a-42d7-b76a-23b2c95af121",
  @ipv4_address_scope=nil,
  @ipv6_address_scope=nil,
  @mtu=1450,
  @name="Test1",
  @port_security_enabled=true,
  @provider={"physical_network"=>nil, "segmentation_id"=>75, "network_type"=>"vxlan"},
  @qos_policy_id=nil,
  @router={"external"=>false},
  @shared=false,
  @status="ACTIVE",
  @subnets=["60fe7990-3db3-4149-a46a-d7a6454a3f2e"],
  @tags=[],
  @tenant_id="48985e6b8da145699d411f12a3459fca",
```

```
pry(main)> networks[0].id
=> "67ef2b90-6217-4c0d-a022-80e48f7f60e6"
```

```
pry(main)> networks[0].name
=> "Test1"
```

```
pry(main)> networks[0].class
=> Foggy::Networking::Networks::Network
```

```
pry(main)> network = cloud.networking.networks.get("f3180183-9e7a-42d7-b76a-23b2c95af121")
../...
network.name="new name"
```

```
pry(main)> cloud.networking.networks.reload
.../...
```

```
pry(main)> subnets = cloud.networking.subnets.all
=> [#<Foggy::Networking::Subnets::Subnet:0x007faa577c3e00
  @allocation_pools=[{"start"=>"10.60.10.2", "end"=>"10.60.10.254"}],
  @cidr="10.60.10.0/24",
  @created_at="2016-11-16T04:36:13",
  @description="",
  @dns_nameservers=[],
  @enable_dhcp=true,
  @gateway_ip="10.60.10.1",
  @host_routes=[],
  @id="60fe7990-3db3-4149-a46a-d7a6454a3f2e",
  @ip_version=4,
  @ipv6_address_mode=nil,
  @ipv6_ra_mode=nil,
  @name="Testsub1",
  @network_id="f3180183-9e7a-42d7-b76a-23b2c95af121",
  @subnetpool_id=nil,
  @tenant_id="48985e6b8da145699d411f12a3459fca",
```
