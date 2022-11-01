data "aws_ami" "amazon-linux-2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

variable "name" {
  description = "The name used to namespace all resources"
  type        = string
  default     = "terraform-example"
}

# variable "ami" {
#   description = "The AMI to run on the instance"
#   type        = string
#   default     = "ami-02f3416038bdb17fb"
# }

variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The Key Pair to associate with the EC2 instance"
  type        = string
  default     = "aws"
}

variable "ssh_port" {
  description = "Open SSH access on this port"
  type        = number
  default     = 22
}

variable "allow_ssh_from_cidrs" {
  description = "Allow SSH access from these CIDR blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
