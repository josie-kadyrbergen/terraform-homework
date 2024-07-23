variable region {
  type = string
}

variable route_table_names {
  type = list(string)
}

variable internet_gateway_name {
  type = string
}

variable vpc {
  type = list(object ({cidr = string, dns_support = bool, dns_hostnames = bool}))
}

variable subnet {
  type = list(object ({cidr = string, name = string}))
}

variable ec2_instances {
  type = list(object ({instance_type = string, name = string}))
}

variable port {
  type = list(number)
}
