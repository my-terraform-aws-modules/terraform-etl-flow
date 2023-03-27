variable "region" {
  type    = string
  default = "eu-west-2"
}
variable "project" {
  default = "test1"
}
variable "createdby" {
  default = "GS"
}
variable "environment" {
  description = "The environment to deploy to."
  type        = string
  default     = "uat"
  validation {
    condition     = contains(["dev", "prod", "sit", "snd", "uat"], var.environment)
    error_message = "Valid values for var: environment are (dev, prod, sit, snd, uat)."
  }
}
##################################################################
###################    KMS      #################################
variable "create_kms" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}
variable "create_alias" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}
variable "kms_name" {
  type    = string
  default = "demo"
}
variable "deletion_window_in_days" {
  type    = number
  default = 7
}
################################################################
################################### S3 ##################################
variable "create_s3" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}
variable "s3_name" {
  type    = string
  default = "demo98765lkj"
}
variable "create_block_public_access" {
  type    = bool
  default = true
}
variable "s3_enable_encryption" {
  description = "Determines whether encryption will be created (affects all resources)"
  type        = bool
  default     = true
}
variable "s3_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for s3"
  type        = string
  default     = ""
}
variable "create_bucket_notification" {
  description = "Determines whether encryption will be created (affects all resources)"
  type        = bool
  default     = true
}
variable "sqs_arn" {
  description = "arn of sqs service"
  type        = string
  default     = ""
}
################################################################
########################### SQS  ######################################
variable "create_sqs" {
  description = "Whether to create SQS queue"
  type        = bool
  default     = true
}
variable "sqs_name" {
  description = "This is the human-readable name of the queue. If omitted, Terraform will assign a random name"
  type        = string
  default     = "demosqs"
}
variable "sqs_enable_encryption" {
  type        = bool
  description = "Whether or not to use encryption for SNS Topic. If set to `true` and no custom value for KMS key (kms_master_key_id) is provided, it uses the default `alias/aws/sns` KMS key."
  default     = true
}
variable "sqs_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = ""
}
variable "create_queue_policy" {
  description = "Whether to create SQS queue policy"
  type        = bool
  default     = true
}

variable "create_dlq" {
  description = "Determines whether to create SQS dead letter queue"
  type        = bool
  default     = true
}
variable "dlq_name" {
  description = "This is the human-readable name of the queue. If omitted, Terraform will assign a random name"
  type        = string
  default     = "demodlq"
}
variable "enable_dlq_encryption" {
  type        = bool
  description = "Whether or not to use encryption for SNS Topic. If set to `true` and no custom value for KMS key (kms_master_key_id) is provided, it uses the default `alias/aws/sns` KMS key."
  default     = true
}

variable "dlq_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = ""
}

variable "dlq_tags" {
  description = "A mapping of additional tags to assign to the dead letter queue"
  type        = map(string)
  default     = {}
  
}
variable "enable_sqs_lambda_trigger" {
  description = "lambda trigger from sqs"
  type = bool
  default = true
}
variable "lambda_arn" {
  type = string
  default = ""
    
}
variable "s3_arn" {
  type = string
  default = ""
  
}
###############################################################
variable "create-function" {
    type = bool
    default = true 
}
variable "lambda_name" {
    type = string
    default = "demo-function" 
}
variable "runtime" {
    type = string
    default = "python3.9"  
}
variable "lambda_handler" {
    description = "give filename & function name which you have mentioned in the file"
    default = "process_sqs.lambda_handler"
}
variable"create_role"{
    type = bool
    default = true
}
variable "lambda_role" {
    type = string
    default = "" 
}
variable "create-event-invoke" {
    type = bool
    default = false 
}
variable "sns_arn" {  
    type = string
    default = ""
}
variable "dynamo_id" {
    type = string
    default = ""  
}

