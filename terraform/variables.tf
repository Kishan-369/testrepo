variable "aws_region" {
  description = "AWS region"
  default     = "us-west-1"
}

variable "aws_account_id" {
  description = "AWS Account ID"
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  default     = "hello-world-repo"
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name"
  default     = "hello-world-cluster"
}

variable "ecs_service_name" {
  description = "ECS Service name"
  default     = "hello-world-service"
}

variable "task_definition_name" {
  description = "Task Definition name"
  default     = "hello-world-task"
}
