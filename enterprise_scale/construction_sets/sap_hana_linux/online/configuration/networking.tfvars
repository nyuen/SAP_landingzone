vnets = {
  sap_hana = {
    resource_group_key = "sap_hana"
    vnet = {
      name          = "sap-hana-vnet"
      address_space = ["10.12.0.0/16"]
    }
    specialsubnets = {
      gateway = {
        name    = "gateway"
        cidr    = ["10.12.2.0/24"]
        enforce_private_link_endpoint_network_policies = true
        enforce_private_link_service_network_policies  = true
      }
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet"
        cidr    = ["10.12.3.0/27"]
        enforce_private_link_endpoint_network_policies = true
        enforce_private_link_service_network_policies  = true
      }
    }
    subnets = {
      application = {
        name    = "application"
        cidr    = ["10.12.0.0/24"]
        enforce_private_link_endpoint_network_policies = true
        enforce_private_link_service_network_policies  = true
      }
      database = {
        name    = "database"
        cidr    = ["10.12.1.0/24"]
        enforce_private_link_endpoint_network_policies = true
        enforce_private_link_service_network_policies  = true
      }
    }
  }
}

load_balancers = {
  app_ilb = {
    name                      = "app_ilb"
    sku                       = "basic"
    resource_group_key        = "sap_hana"
    backend_address_pool_name = "sgh-ascs-backpool"
    frontend_ip_configurations = {
      LoadBalancerFrontEnd = {
        name                          = "LoadBalancerFrontEnd"
        vnet_key                      = "sap_hana"
        subnet_key                    = "application"
        private_ip_address_allocation = "Dynamic"
      }
      sgh-ers-ilb = {
        name                          = "sgh-ers-ilb"
        vnet_key                      = "sap_hana"
        subnet_key                    = "application"
        private_ip_address_allocation = "Dynamic"
      }
    }
        #multiple VMs and NICs can be attached to the Load Balancer. Specify the respective VMs and NICs in the following syntac
    nic_bap_association = {
      ascsvm1_agent = {
        vm_key  = "ascsvm1_agent"
        nic_key = "nic0"
      }
      ascsvm2_agent = {
        vm_key  = "ascsvm2_agent"
        nic_key = "nic0"
      }
    }

    probe = {
      resource_group_key = "sap_hana"
      load_balancer_key  = "app_ilb"
      probe_name         = "ers-62102"
      port               = "62102"
    }

    lb_rules = {
      sgh-lb-3200 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "sgh-lb-3200"
        protocol                       = "tcp"
        frontend_port                  = "3200"
        backend_port                   = "3200"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
      }
      sgh-lb-3600 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "sgh-lb-3600"
        protocol                       = "tcp"
        frontend_port                  = "3600"
        backend_port                   = "3600"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
      }
      sgh-lb-3900 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "sgh-lb-3900"
        protocol                       = "tcp"
        frontend_port                  = "3900"
        backend_port                   = "3900"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
      }
      sgh-lb-50013 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "sgh-lb-50013"
        protocol                       = "tcp"
        frontend_port                  = "50013"
        backend_port                   = "50013"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
      }
      sgh-lb-50014 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "sgh-lb-50014"
        protocol                       = "tcp"
        frontend_port                  = "50014"
        backend_port                   = "50014"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
      }
      sgh-lb-50016 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "sgh-lb-50016"
        protocol                       = "tcp"
        frontend_port                  = "50016"
        backend_port                   = "50016"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
      }
      sgh-lb-8100 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "sgh-lb-8100"
        protocol                       = "tcp"
        frontend_port                  = "8100"
        backend_port                   = "8100"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
      }
      ers-lb-3302 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "ers-lb-3302"
        protocol                       = "tcp"
        frontend_port                  = "3302"
        backend_port                   = "3302"
        frontend_ip_configuration_name = "sgh-ers-ilb" #name must match the configuration that's defined in the load_balancers block.
      }
      ers-lb-50213 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "ers-lb-50213"
        protocol                       = "tcp"
        frontend_port                  = "50213"
        backend_port                   = "50213"
        frontend_ip_configuration_name = "sgh-ers-ilb" #name must match the configuration that's defined in the load_balancers block.
      }
      ers-lb-50214 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "ers-lb-50214"
        protocol                       = "tcp"
        frontend_port                  = "50214"
        backend_port                   = "50214"
        frontend_ip_configuration_name = "sgh-ers-ilb" #name must match the configuration that's defined in the load_balancers block.
      }
      ers-lb-50216 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "ers-lb-50216"
        protocol                       = "tcp"
        frontend_port                  = "50216"
        backend_port                   = "50216"
        frontend_ip_configuration_name = "sgh-ers-ilb" #name must match the configuration that's defined in the load_balancers block.
      }
      ers-lb-3202 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "app_ilb"
        lb_rule_name                   = "ers-lb-3202"
        protocol                       = "tcp"
        frontend_port                  = "3202"
        backend_port                   = "3202"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
      }
    }
   }

  db_ilb = {
    name                      = "db_ilb"
    sku                       = "Standard"
    resource_group_key        = "sap_hana"
    backend_address_pool_name = "hana-backpool"
    frontend_ip_configurations = {
      LoadBalancerFrontEnd = {
        name                          = "LoadBalancerFrontEnd"
        vnet_key                      = "sap_hana"
        subnet_key                    = "database"
        private_ip_address_allocation = "Dynamic"
      }
    }
        #multiple VMs and NICs can be attached to the Load Balancer. Specify the respective VMs and NICs in the following syntac
    nic_bap_association = {
      hanavm1 = {
        vm_key  = "hanavm1"
        nic_key = "nic0"
      }
      hanavm2 = {
        vm_key  = "hanavm2"
        nic_key = "nic0"
      }
    }

    probe = {
      resource_group_key = "sap_hana"
      load_balancer_key  = "db_ilb"
      probe_name         = "62500"
      port               = "62500"
    }

    lb_rules = {
      hana-lb-30013 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "db_ilb"
        lb_rule_name                   = "hana-lb-30013"
        protocol                       = "tcp"
        frontend_port                  = "30013"
        backend_port                   = "30013"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd"
        enable_floating_ip             = true #name must match the configuration that's defined in the load_balancers block.
      }
      hana-lb30003-tenantdb = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "db_ilb"
        lb_rule_name                   = "hana-lb30003-tenantdb"
        protocol                       = "tcp"
        frontend_port                  = "30003"
        backend_port                   = "30003"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
        enable_floating_ip             = true #name must match the configuration that's defined in the load_balancers block.
      }
      hana-lb-30007-tenantdb = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "db_ilb"
        lb_rule_name                   = "hana-lb-30007-tenantdb"
        protocol                       = "tcp"
        frontend_port                  = "30007"
        backend_port                   = "30007"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
        enable_floating_ip             = true #name must match the configuration that's defined in the load_balancers block.
      }
      hana-lb-50013 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "db_ilb"
        lb_rule_name                   = "hana-lb-50013"
        protocol                       = "tcp"
        frontend_port                  = "50013"
        backend_port                   = "50013"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
        enable_floating_ip             = true #name must match the configuration that's defined in the load_balancers block.
      }
    }
   }

  nfs_ilb = {
    name                      = "nfs_ilb"
    sku                       = "Basic"
    resource_group_key        = "sap_hana"
    backend_address_pool_name = "nfs-backpool"
    frontend_ip_configurations = {
      LoadBalancerFrontEnd = {
        name                          = "LoadBalancerFrontEnd"
        vnet_key                      = "sap_hana"
        subnet_key                    = "application"
        private_ip_address_allocation = "Dynamic"
      }
    }
        #multiple VMs and NICs can be attached to the Load Balancer. Specify the respective VMs and NICs in the following syntac
    nic_bap_association = {
      nfsvm1 = {
        vm_key  = "nfsvm1"
        nic_key = "nic0"
      }
      nfsvm2 = {
        vm_key  = "nfsvm2"
        nic_key = "nic0"
      }
    }

    probe = {
      resource_group_key = "sap_hana"
      load_balancer_key  = "nfs_ilb"
      probe_name         = "61000"
      port               = "61000"
    }

    lb_rules = {
      nfs-lb-udp2049 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "nfs_ilb"
        lb_rule_name                   = "nfs-lb-udp2049"
        protocol                       = "udp"
        frontend_port                  = "2049"
        backend_port                   = "2049"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd"
      }
      fs-lb-2049 = {
        idle_timeout_in_minutes        = "30"
        resource_group_key             = "sap_hana"
        load_balancer_key              = "nfs_ilb"
        lb_rule_name                   = "fs-lb-2049"
        protocol                       = "tcp"
        frontend_port                  = "2049"
        backend_port                   = "2049"
        frontend_ip_configuration_name = "LoadBalancerFrontEnd" #name must match the configuration that's defined in the load_balancers block.
      }
    }
   }
}
