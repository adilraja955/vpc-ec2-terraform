resource "aws_key_pair" "bastion" {
  key_name   = "terraform-bastion"
  public_key = file("~/.ssh/terraform-bastion.pub")

  tags = {
    Name = "terraform-bastion-key"
  }
}