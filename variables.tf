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
  default     = false
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
  description = "Determines whether notification will be created (affects all resources)"
  type        = bool
  default     = true
}
variable "create_bucket_notification_for_existing_resource" {
  description = "Determines whether notification will be created (affects all resources)"
  type        = bool
  default     = false
}
variable "bucket_id" {
  type = string
  default = ""
  
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
variable "enable_sqs_lambda_trigger_for_existing_resource" {
  description = "lambda trigger from sqs existing resource"
  type = bool
  default = false
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
###################  LAMBDA  #######################
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
    default = true 
}
variable "create-event-invoke_for_existing_resource" {
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
##################################################################
########################dynamodb##################################
variable "create_table" {
  description = "Controls if DynamoDB table and associated resources are created"
  type        = bool
  default     = true
}

variable "dynamodb_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "demoddb"
}
variable "attributes" {
  description = "List of nested attribute definitions. Only required for hash_key and range_key attributes. Each attribute has two properties: name - (Required) The name of the attribute, type - (Required) Attribute type, which must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data"
  type        = list(map(string))
  default     = [
    {
      name : "UserId"
      type : "S"
    }
  ]
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key. Must also be defined as an attribute"
  type        = string
  default     = "UserId"
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key. Must also be defined as an attribute"
  type        = string
  default     = null
}

variable "billing_mode" {
  description = "Controls how you are billed for read/write throughput and how you manage capacity. The valid values are PROVISIONED or PAY_PER_REQUEST"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "write_capacity" {
  description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = null
}

variable "read_capacity" {
  description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = null
}

variable "point_in_time_recovery_enabled" {
  description = "Whether to enable point-in-time recovery"
  type        = bool
  default     = false
}

variable "ttl_enabled" {
  description = "Indicates whether ttl is enabled"
  type        = bool
  default     = false
}

variable "ttl_attribute_name" {
  description = "The name of the table attribute to store the TTL timestamp in"
  type        = string
  default     = ""
}

variable "global_secondary_indexes" {
  description = "Describe a GSI for the table; subject to the normal limits on the number of GSIs, projected attributes, etc."
  type        = any
  default     = []
}

variable "local_secondary_indexes" {
  description = "Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource."
  type        = any
  default     = []
}

variable "replica_regions" {
  description = "Region names for creating replicas for a global DynamoDB table."
  type        = any
  default     = []
}

variable "stream_enabled" {
  description = "Indicates whether Streams are to be enabled (true) or disabled (false)."
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  type        = string
  default     = null
}

variable "server_side_encryption_enabled" {
  description = "Whether or not to enable encryption at rest using an AWS managed KMS customer master key (CMK)"
  type        = bool
  default     = false
}

variable "dynamo_kms_master_key_id" {
  description = "The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Updated Terraform resource management timeouts"
  type        = map(string)
  default = {
    create = "10m"
    update = "60m"
    delete = "10m"
  }
}
variable "dynamodb_item_create" {
  description = "Controls if DynamoDB table item and associated resources are created"
  type        = bool
  default     = false

}

################################################################################
#                    SNS Topic
################################################################################

variable "create_topic" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}
variable "sns_name" {
  description = "The name of the SNS topic to create"
  type        = string
  default     = "demosns"
}

variable "use_name_prefix" {
  description = "Determines whether `name` is used as a prefix"
  type        = bool
  default     = false
}
variable "sns_enable_encryption" {
  type        = bool
  description = "Whether or not to use encryption for SNS Topic. If set to `true` and no custom value for KMS key (kms_master_key_id) is provided, it uses the default `alias/aws/sns` KMS key."
  default     = false
}
variable "sns_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK"
  type        = string
  default = ""
}

################################################################################
# Topic Policy
################################################################################

variable "create_topic_policy" {
  description = "Determines whether an SNS topic policy is created"
  type        = bool
  default     = true
}
variable "topic_policy" {
  description = "An externally created fully-formed AWS policy as JSON"
  type        = string
  default     = null
}

variable "source_topic_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s"
  type        = list(string)
  default     = []
}

variable "override_topic_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid`"
  type        = list(string)
  default     = []
}

variable "enable_default_topic_policy" {
  description = "Specifies whether to enable the default topic policy. Defaults to `true`"
  type        = bool
  default     = true
}

variable "topic_policy_statements" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage"
  type        = any
  default     = {}
}

################################################################################
# Subscription(s)
################################################################################
variable "enable_email_subscribe" {
    type = bool
    default = false
  
}
variable "enable_lambda_subscribe" {
    type = bool
    default = false
  
}
variable "enable_sqs_subscribe" {
    type = bool
    default = false
  
}
variable "email_endpoint" {
    type = string
    default = ""
}
variable "lambda_endpoint" {
    type = string
    default = ""
  
}
variable "sqs_endpoint" {
    type = string
    default = ""
  
}

