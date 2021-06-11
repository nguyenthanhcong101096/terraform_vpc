output "sg_public_id" {
  value = aws_security_group.public_sg.id
}

output "sg_private_id" {
  value = aws_security_group.private_sg.id
}
