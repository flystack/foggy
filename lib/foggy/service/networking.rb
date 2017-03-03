require "foggy/service"

module Foggy
  class Networking < Foggy::Service
    define :extensions
    define :floating_ips
    define :ike_policies, :ike_policy
    define :ipsec_policies, :ipsec_policy
    define :ipsec_site_connections
    define :lb_health_monitors
    define :lb_members
    define :lb_pools
    define :lb_vips
    define :networks
    define :ports
    define :rbac_policies
    define :routers
    define :security_group_rules
    define :security_groups
    define :subnet_pools
    define :subnets
    define :vpn_services
  end
end
