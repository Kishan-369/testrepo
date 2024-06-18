output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "ecs_service_name" {
  value = aws_ecs_service.hello_world_service.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.hello_world_repo.repository_url
}
