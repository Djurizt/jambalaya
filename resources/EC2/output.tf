output "root_instance_id" {
  description = "The ID of the EC2 instance from the child module"
  value       = module.EC2.instance_id
}