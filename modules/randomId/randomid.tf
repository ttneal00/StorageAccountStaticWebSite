resource "random_id" "randomId" {
  byte_length = 4

}

output "id" {
  value = random_id.randomId.id

}

output "hex" {
  value = random_id.randomId.hex

}