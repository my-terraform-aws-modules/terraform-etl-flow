
#to overwrite module variable defalut values .tfvars files can be used
#command terraform apply -var-file="dev.tfvars" --auto-approve
#locals..> can use the name multiple times within a module instead of repeating the expression.

locals {
  policy = data.aws_iam_policy_document.queue.json
  tags = {
    Project     = var.project
    createdby   = var.createdby
    environment = var.environment
  }
}

module "kms_module" {
  source       = "git::https://github.com/archna94/terraform-aws-kms.git"
  create_kms   = var.create_kms
  create_alias = var.create_alias
  environment = var.environment
  kms_name = var.kms_name 
  deletion_window_in_days = var.deletion_window_in_days
  tags                    = local.tags

}

module "s3_module" {
  source    = "git::https://github.com/archna94/terraform_aws_s3.git"
  create_s3 = var.create_s3
  #bucket name given as #bucket = "${var.environment}-${var.s3_name}"
  environment = var.environment
  s3_name   = var.s3_name
  create_block_public_access = var.create_block_public_access
  tags                       = local.tags
  s3_enable_encryption       = var.s3_enable_encryption
  #s3_kms_master_key_id = var.s3_kms_master_key_id
  s3_kms_master_key_id       = module.kms_module.key_arn
  create_bucket_notification = var.create_bucket_notification
  #sqs_arn                    = var.sqs_arn
  sqs_arn = module.sqs_module.queue_arn 
}

module "sqs_module" {
  source = "git::https://github.com/my-terraform-aws-modules/terraform-aws-sqs.git"
  create_sqs = var.create_sqs
  environment = var.environment
  sqs_name = var.sqs_name
  tags = local.tags
  create_dlq = var.create_dlq
  dlq_name = var.dlq_name
  sqs_enable_encryption = var.sqs_enable_encryption 
  #sqs_kms_master_key_id = var.sqs_kms_master_key_id
  sqs_kms_master_key_id = module.kms_module.key_arn
  enable_dlq_encryption = var.enable_dlq_encryption
 #dlq_kms_master_key_id = var.dlq_kms_master_key_id
  dlq_kms_master_key_id = module.kms_module.key_arn
  #s3_arn = var.s3_arn
  create_queue_policy = var.create_queue_policy
  s3_arn = module.s3_module.s3_arn
  #lambda_arn = var.lambda_arn
  enable_sqs_lambda_trigger = var.enable_sqs_lambda_trigger
  lambda_arn = module.lambda_module.lambda_arn
}

module "lambda_module" {
  source = "git::https://github.com/my-terraform-aws-modules/terraform-aws-lambda.git"
  create-function = var.create-function
  environment = var.environment
  lambda_name = var.lambda_name
  runtime = var.runtime
  lambda_handler = var.lambda_handler
  create_role = var.create_role
  lambda_role = var.lambda_role
  tags = local.tags
  #dynamo_id = var.dynamo_id
  create-event-invoke = var.create-event-invoke
  sns_arn = var.sns_arn
  
}
/*
module "sns_module" {
  source = "./modules/sns"
  tags = local.tags
  kms_master_key_id = module.kms_module.key_arn
  lambda_endpoint = module.lambda_module.lambdaa_arn
  sqs_endpoint = module.sqs_module.queue_arn
}
module "dynamodb_module" {
  source = "./modules/dynamodb"
  tags = local.tags
  kms_master_key_id = var.
  
}
module "redshift_module" {
  source = "git::"
  tags = local.tags
}

*/






