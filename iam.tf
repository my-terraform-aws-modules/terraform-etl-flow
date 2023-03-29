# data "aws_iam_policy_document" "queue" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }

#     actions   = ["sqs:sendMessage"]
#     resources = ["arn:aws:sqs:*:*:*"]

#     condition {
#       test     = "ArnEquals"
#       variable = "aws:SourceArn"
#       values   = [var.s3_arn]
#     }
#   }
# }
