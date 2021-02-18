resource "aws_instance" "instance_docker" {
  ami = var.ami_id
  instance_type = var.ami_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  associate_public_ip_address = false
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    Name = "Docker"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      agent = false
      timeout = "40s"
      user = var.ssh_user
      host = aws_instance.instance_docker.public_dns
      private_key = tls_private_key.t.private_key_pem
    }
    inline = [
      "sudo yum install docker -y",
      "docker --version",
      "sudo service docker start",
      "sudo service docker status"
    ]
  }
}