output "instance_ips" {
  value = module.compute.instance_ips
}

output "resource_summary" {
  value = {
    vpcs       = 1
    subnets    = length(module.network.public_subnet_ids)
    instances  = length(module.compute.instance_ids)
    s3_buckets = 1
    databases  = 1
  }
}