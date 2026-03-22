# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "ballogadget_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "lambda.amazonaws.com" } }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/hello.py"
  output_path = "${path.module}/lambda/hello.zip"
}

resource "aws_lambda_function" "quest_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "BalloGadget-Quest-Lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "hello.lambda_handler"
  runtime       = "python3.12"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# In Bangkok (ap-southeast-7), we'll skip Function URL for now due to account/region restrictions
# and just keep the function for verification in the console.

output "lambda_function_name" {
  value = aws_lambda_function.quest_lambda.function_name
}
