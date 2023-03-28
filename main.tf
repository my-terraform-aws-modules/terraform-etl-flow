
#to overwrite module variable defalut values .tfvars files can be used
#command terraform apply -var-file="dev.tfvars" --auto-approve
#locals..> can use the name multiple times within a module instead of repeating the expression.
data "archive_file" "lambda_dynamo" {
  type        = "zip"
  source_file = "${path.module}/python/lambda-dynamo/lambda_dynamo.py"
  output_path = "${path.module}/python/lambda-dynamo/lambda_dynamo.zip"
}
locals {
  package_filename = data.archive_file.lambda_dynamo.output_path
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

resource "aws_s3_bucket_notification" "notification" {
    count = var.create_bucket_notification_for_existing_resource ? 1 : 0
    bucket = var.bucket_id
    queue {
    queue_arn     = var.sqs_arn
    events        = ["s3:ObjectCreated:*"]
  }
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

resource "aws_lambda_event_source_mapping" "Example" {
  count = var.enable_sqs_lambda_trigger_for_existing_resource ? 1 : 0
  event_source_arn = var.sqs_arn
  function_name    = var.lambda_arn
}

module "lambda_module" {
  source = "git::https://github.com/my-terraform-aws-modules/terraform-aws-lambda.git"
  create-function = var.create-function
  environment = var.environment
  lambda_name = var.lambda_name
  package_filename = local.package_filename
  runtime = var.runtime
  lambda_handler = var.lambda_handler
  create_role = var.create_role
  lambda_role = var.lambda_role
  tags = local.tags
  #dynamo_id = var.dynamo_id
  create-event-invoke = var.create-event-invoke
  #sns_arn = var.sns_arn
  sns_arn = module.sns_module.sns_arn
  
}

resource "aws_lambda_function_event_invoke_config" "example" {
  count = var.create-event-invoke_for_existing_resource ? 1 : 0
  function_name = var.lambda_arn
  destination_config {
    on_failure {
      destination = var.sns_arn
    }

    on_success {
      destination = var.sns_arn
    }
  }
}


module "sns_module" {
  source = "git::https://github.com/my-terraform-aws-modules/terraform-aws-sns.git"
  create_topic = var.create_topic
  environment = var.environment
  sns_name = var.sns_name
  sns_enable_encryption = var.sns_enable_encryption
  #sns_kms_master_key_id = var.sns_kms_master_key_id
  create_topic_policy = var.create_topic_policy
  topic_policy = var.topic_policy
  enable_default_topic_policy = var.enable_default_topic_policy
  enable_lambda_subscribe = var.enable_lambda_subscribe
  #lambda_endpoint = var.lambda_endpoint
  enable_email_subscribe = var.enable_email_subscribe
  email_endpoint = var.email_endpoint
  enable_sqs_subscribe = var.enable_sqs_subscribe
  #sqs_endpoint = var.sqs_endpoint
  
  tags = local.tags
  sns_kms_master_key_id = module.kms_module.key_arn
  lambda_endpoint = module.lambda_module.lambda_arn
  sqs_endpoint = module.sqs_module.queue_arn
}
module "dynamodb_module" {
  source = "git::https://github.com/my-terraform-aws-modules/terraform-aws-dynamodb.git"
  create_table = var.create_table
  environment = var.environment
  dynamodb_name = var.dynamodb_name
  attributes = var.attributes
  hash_key = var.hash_key
  range_key = var.range_key
  server_side_encryption_enabled = var.server_side_encryption_enabled
  dynamo_kms_master_key_id = var.dynamo_kms_master_key_id
  billing_mode = var.billing_mode
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type
  ttl_enabled = var.ttl_enabled
  ttl_attribute_name = var.ttl_attribute_name
  tags = local.tags
  point_in_time_recovery_enabled = var.point_in_time_recovery_enabled
  local_secondary_indexes = var.local_secondary_indexes
  global_secondary_indexes = var.global_secondary_indexes
  dynamodb_item_create = var.dynamodb_item_create
 
}





