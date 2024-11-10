resource "aws_key_pair" "this" {
  provider = aws.primary
  key_name = var.name

  public_key = var.public_key
}
