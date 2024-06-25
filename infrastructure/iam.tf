data "aws_iam_policy_document" "event_handler" {
  statement {
    sid = "EventHandlerPolicy"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:aws:logs:*:*:*", # Allow actions on all CloudWatch Logs resources
    ]
  }
}

resource "aws_iam_role" "event_handler_execution_role" {
  name = "event_handler_execution_role_${var.environment}"
  path = "/service-role/"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )

  max_session_duration = 3600
}

resource "aws_iam_role_policy" "event_handler" {
  name   = "${var.function_name}_${var.environment}"
  role   = aws_iam_role.event_handler_execution_role.id
  policy = data.aws_iam_policy_document.event_handler.json
}

# Reference the existing IAM user
data "aws_iam_user" "terraform_user" {
  user_name = "kolly22@gmail.com"
}

# Define the IAM policy
resource "aws_iam_policy" "terraform_user_policy" {
  name        = "terraform_user_policy"
  description = "Policy for the user running Terraform to create necessary resources"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:GetLogEvents",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutRetentionPolicy",
          "logs:ListTagsForResource",
          "logs:ListAnomalies",
          "logs:DescribeSubscriptionFilters",
          "logs:DescribeAccountPolicies",
          "logs:GetDataProtectionPolicy",
          "iam:CreateRole",
          "iam:AttachRolePolicy",
          "iam:PassRole",
          "lambda:CreateFunction",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "apigateway:POST",
          "apigateway:PUT",
          "apigateway:GET",
          "apigateway:DELETE",
          "apigateway:GET",
          "apigateway:GET /restapis",
          "apigatewayv2:GET",
          "apigatewayv2:GET /apis"
        ],
        "Resource" : "*"
      }
    ]
  })
}

# Attach the policy to the existing IAM user
resource "aws_iam_user_policy_attachment" "terraform_user_policy_attachment" {
  user       = data.aws_iam_user.terraform_user.user_name
  policy_arn = aws_iam_policy.terraform_user_policy.arn
}