output "server-ip" {
  value = aws_instance.instance_docker.public_ip
}