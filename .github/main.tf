name: Deploy to ECS

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4  # Updated to Node.js 20 compatible version

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2  # Updated to Node.js 20 compatible version

      - name: Log in to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2  # Updated to Node.js 20 compatible version
        with:
          access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          region: ${{ secrets.AWS_REGION }}  # Ensure this is defined in your secrets

      - name: Build, tag, and push Docker image
        env:
          ECR_REPOSITORY: your-ecr-repository
          AWS_REGION: ${{ secrets.AWS_REGION }}
          AWS_ACCOUNT_ID: ${{ secrets.AWS_ACCOUNT_ID }}
          ECR_REGISTRY: ${{ secrets.ECR_REGISTRY }}
        run: |
          IMAGE_TAG=latest
          aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
          docker build -t $ECR_REPOSITORY:$IMAGE_TAG .
          docker tag $ECR_REPOSITORY:$IMAGE_TAG $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG

      - name: Deploy to ECS
        env:
          AWS_REGION: ${{ secrets.AWS_REGION }}
          CLUSTER_NAME: ${{ secrets.CLUSTER_NAME }}
          SERVICE_NAME: ${{ secrets.SERVICE_NAME }}
        run: |
          aws ecs update-service --cluster $CLUSTER_NAME --service $SERVICE_NAME --force-new-deployment --region $AWS_REGION
