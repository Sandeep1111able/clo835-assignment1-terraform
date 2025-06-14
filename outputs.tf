output "public_ip" {
  value = aws_instance.webapp_ec2.public_ip
}