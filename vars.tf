variable "access_key" {
}

variable "secret_key" {
}

variable "AWS_REGION" {
  default = "us-west-1"
}

variable "CIDR_BLOCK"{
  default = "10.0.0.0/16"
}

variable "SUB_1_CIDR"{
  default = "10.0.1.0/24"
}

variable "AZ_1"{
  default = "us-west-1b"
}

variable "SUB_2_CIDR"{
  default = "10.0.2.0/24"
}

variable "SUB_3_CIDR"{
  default = "10.0.3.0/24"
}

variable "AZ_2"{
  default = "us-west-1c"
}

variable "ports"{
  type = map(list(string))
  default = {
    3306 = ["10.0.0.0/16"]
  }
}
