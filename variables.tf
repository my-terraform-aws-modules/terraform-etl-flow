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
variable "create_kms_policy" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
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
variable "create_canned_acl" {
  description = "Whether to use a canned ACL."
  type        = bool
  default = true
}

variable "canned_acl" {
  description = "The canned ACL to apply to the bucket."
  type        = string
  default     = "private"

  validation {
    condition = contains([
      "private",
      "public-read",
      "public-read-write",
      "aws-exec-read",
      "authenticated-read",
      "bucket-owner-read",
      "bucket-owner-full-control",
      "log-delivery-write",
    ], var.canned_acl)

    error_message = "Canned ACL not one of the allowed types."
  }
}
variable "lifecycle_rules" {
  type = list(object({
    id     = string,
    status = string,

    noncurrent_version_transition = optional(list(object({
      noncurrent_days = number
      storage_class   = string
    })), [])
  }))

  default = []
}

variable "versioning_enabled" {
  description = "Whether versioning is enabled for bucket objects."
  type        = bool
  default     = true
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
variable "s3_bucket_id" {
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
variable "queue_arn" {
  type = string
  default = ""
    
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
    default = "lambda_dynamo.lambda_handler"
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
variable "snsname" {
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


variable "enable_default_topic_policy" {
  description = "Specifies whether to enable the default topic policy. Defaults to `true`"
  type        = bool
  default     = true
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

################################################################################
#                    SNS Topic2
################################################################################

variable "create_topic2" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}
variable "sns-name2" {
  description = "The name of the SNS topic to create"
  type        = string
  default     = "demosns2"
}

variable "sns_enable_encryption2" {
  type        = bool
  description = "Whether or not to use encryption for SNS Topic. If set to `true` and no custom value for KMS key (kms_master_key_id) is provided, it uses the default `alias/aws/sns` KMS key."
  default     = false
}
variable "sns_kms_master_key_id2" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK"
  type        = string
  default = ""
}

################################################################################
# Topic Policy
################################################################################

variable "create_topic_policy2" {
  description = "Determines whether an SNS topic policy is created"
  type        = bool
  default     = true
}
variable "topic_policy2" {
  description = "An externally created fully-formed AWS policy as JSON"
  type        = string
  default     = null
}


variable "enable_default_topic_policy2" {
  description = "Specifies whether to enable the default topic policy. Defaults to `true`"
  type        = bool
  default     = true
}



################################################################################
# Subscription(s)
################################################################################
variable "enable_email_subscribe2" {
    type = bool
    default = false
  
}
variable "enable_lambda_subscribe2" {
    type = bool
    default = false
  
}
variable "enable_sqs_subscribe2" {
    type = bool
    default = false
  
}
variable "email_endpoint2" {
    type = string
    default = ""
}
variable "lambda_endpoint2" {
    type = string
    default = ""
}
variable "sqs_endpoint2" {
    type = string
    default = ""
}

#############################################################
###############  step function ###########################
variable "state_machine_tags" {
  description = "The tags provided by the client module. To be merged with internal tags"
  type        = map(string)
  default     = {}
}

variable "state_machine_name" {
  type        = string
  description = "The name of the state machine."
  default = "demo"
}

variable "type" {
  type        = string
  description = "Determines whether a Standard or Express state machine is created."
  default = "Standard"
}

variable "include_execution_data" {
  type        = bool
  description = "Determines whether execution data is included in your log. When set to false, data is excluded."
  default = false
}


variable "logging_configuration_level" {
  type        = string
  description = "Defines which category of execution history events are logged. Valid values: ALL, ERROR, FATAL, OFF"
  default = "ALL"
  validation {
    condition = contains([
      "ALL", "ERROR", "FATAL", "OFF"
    ], var.logging_configuration_level)
    error_message = "Must be one of the allowed values."
  }
}

variable "cloudwatch_log_group_name" {
  type        = string
  description = "The name of the Cloudwatch log group."
  default = "demologgroup"
}

variable "cloudwatch_log_group_tags" {
  description = "The tags provided by the client module. To be merged with internal tags"
  type        = map(string)
  default     = {}
}

variable "iam_role_name" {
  type        = string
  description = "The name given to the iam role used by the state machine."
  default = "demorole"
}

variable "enable_sfn_encyption" {
  type = bool
  default = false  
}

variable "cloudwatch_log_group_kms_key_arn" {
  type        = string
  description = "The ARN of the KMS Key to use when encrypting log data."
  default = ""
}

variable "definition_file_name" {
  type        = string
  description = "The name of the file that contains the state machine definition. File should be in JSON format."
  default = "demodefination"
}

variable "policy_file_name" {
  type        = string
  description = "The name of the file that contains the iam policy. File should be in JSON format."
  default = ""
}

variable "xray_tracing_enabled" {
  type        = bool
  description = "When set to true, AWS X-Ray tracing is enabled."
  default     = true
}

variable "cloudwatch_log_group_retention_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  default = 0
  validation {
    condition = contains([
      0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653
    ], var.cloudwatch_log_group_retention_days)
    error_message = "Must be one of the allowed values."
  }
}


