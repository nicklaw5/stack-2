# ==========================================
# == Required Variables
# ==========================================

# N/A

# ==========================================
# == Optional Variables
# ==========================================

variable "aws_region" {
  description = "The region in which to deploy the VPCs in"
  type        = string
  default     = "ap-southeast-2"
}

variable "repository" {
  description = "The region in which to deploy the instance"
  type        = string
  default     = "stack-2"
}

variable "managed_by" {
  description = "The resource responsible for managing these assets"
  type        = string
  default     = "terraform"
}
