resource "random_string" "random" {
  length  = var.length
  lower   = true
  special = false
}

output "string" {
  value = random_string.random.result
  
}