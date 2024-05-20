provider "aws" {
  region = "us-west-2"
}
 
variable "deploy_asg" {
  description = "The ASG to deploy to"
}
 
variable "desired_capacity" {
  description = "Desired instance count for the ASG"
}
 
data "aws_autoscaling_group" "blue" {
  name = "existing-blue-asg-name"
}
 
data "aws_autoscaling_group" "green" {
  name = "existing-green-asg-name"
}
 
resource "aws_autoscaling_group" "update_blue" {
  count = var.deploy_asg == "blue" ? 1 : 0
name = data.aws_autoscaling_group.blue.name
  desired_capacity = var.desired_capacity
  force_delete = true
  lifecycle {
    ignore_changes = [
      "max_size", "min_size", "launch_configuration", "availability_zones"
    ]
  }
}
 
resource "aws_autoscaling_group" "update_green" {
  count = var.deploy_asg == "green" ? 1 : 0
name = data.aws_autoscaling_group.green.name
  desired_capacity = var.desired_capacity
  force_delete = true
  lifecycle {
    ignore_changes = [
      "max_size", "min_size", "launch_configuration", "availability_zones"
    ]
  }
}
