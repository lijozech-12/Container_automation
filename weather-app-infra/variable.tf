variable "aws_region" {
  description = "The AWS region where resources will be provisioned."
  default     = "us-east-1"
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance."
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  default     = "t2.micro"
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair."
}

variable "s3_bucket_name" {
  description = "lijos-test-bucket"
}

variable "weather-page-docker-compose" {
  description = "The name of docker compose file for weather app"

}

variable "ami_owners" {
  description = "List of AWS account IDs that own the AMI"
  type        = list(string)
  default     = ["099720109477"] # Canonical
}