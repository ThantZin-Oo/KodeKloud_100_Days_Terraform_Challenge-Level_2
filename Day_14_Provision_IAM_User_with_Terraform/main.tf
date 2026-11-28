resource "aws_iam_user" "iamuser_rose" {
  name = var.KKE_USER_NAME
  provisioner "local-exec" {
    command = "echo 'KKE ${self.name} has been created successfully!' > /home/bob/terraform/KKE_user_created.log"
  }
}