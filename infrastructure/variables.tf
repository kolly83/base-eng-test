variable "region" {
  description = "The AWS region to deploy to."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
  default     = "dev"
}

variable "filepath" {
  description = "Path to the function's deployment package within the local filesystem"
  type        = string
  default     = "../package/lambda_function.zip" # Adjusted default path
}

variable "package_type" {
  description = "The package type (Zip or Image) to use for this function."
  type        = string
  default     = "Zip"
}

variable "runtime" {
  description = "The identifier of the function's runtime."
  type        = string
  default     = "python3.10"
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version."
  type        = bool
  default     = true
}

variable "architectures" {
  description = "A list of Lambda function architectures (ARM64 or x86_64) to build and publish to"
  type        = list(string)
  default     = ["x86_64"]
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 30
}

variable "function_name" {
  description = "The name of the Lambda Function."
  type        = string
}

variable "function_handler" {
  description = "The function entrypoint in your code."
  type        = string
  default     = "main.lambda_handler"
}

variable "powertools_service_name" {
  description = "The name of the service."
  type        = string
}

variable "log_level" {
  description = "The log level for the function."
  type        = string
  default     = "INFO"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "The AWS access key ID"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "The AWS secret access key"
  type        = string
  sensitive   = true
}
