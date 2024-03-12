

resource "aws_s3_bucket" "web-bucket" {
  bucket = var.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "web-bucket" {
  bucket = aws_s3_bucket.web-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "web-bucket" {
  bucket = aws_s3_bucket.web-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "web-bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.web-bucket,
    aws_s3_bucket_public_access_block.web-bucket,
  ]

  bucket = aws_s3_bucket.web-bucket.id
  acl    = "public-read"
}

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = var.ami_owners # Canonical
# }

# # resource "aws_key_pair" "deployer" {
# #   key_name   = "deployer-key"
# #   public_key = "/home/lijo/.ssh/id_rsa.pub"

# # }  

# resource "aws_instance" "web-provider" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.instance_type

#   tags = {
#     Name = "web-provider"
#   }

#   user_data = file("${path.module}/setup.sh")


# #   provisioner "file" {
# #     source      = var.weather-page-docker-compose
# #     destination = "/home/ec2-user/weather-page-docker-compose.yml"
# #     connection {
# #       type        = "ssh"
# #       user        = "ec2-user"
# #       private_key = file("~/.ssh/test-webserver.pem") # Replace with your SSH private key path
# #       host        = aws_instance.web-provider.public_ip
# #     }
# #   }

#   #   provisioner "file" {
#   #     source      = "docker-compose-2.yml"
#   #     destination = "/home/ec2-user/docker-compose-2.yml"
#   #   }

# #   provisioner "remote-exec" {
# #     inline = [
# #     "while [ ! -f /var/tmp/user_data_done ]; do sleep 1; done", # Wait for user_data completion
# #       "sudo docker-compose -f /home/ec2-user/weather-page-docker-compose.yml up -d"
# #     ]

# #     connection {
# #       type        = "ssh"
# #       user        = "ec2-user"
# #       private_key = file("~/.ssh/test-webserver.pem") # Replace with your SSH private key path
# #       host        = aws_instance.web-provider.public_ip
# #     }
# #   }

# }

# #   provisioner "file" {
# #     source      = "docker-compose-2.yml"
# #     destination = "/home/ec2-user/docker-compose-2.yml"
# #   }


