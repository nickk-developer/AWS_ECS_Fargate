# Deploying Docker Containers on AWS ECS with Fargate

## Project Overview
This project involves deploying a Dockerized web application on AWS ECS using Fargate. AWS ECS (Elastic Container Service) is a fully managed container orchestration service, and Fargate allows us to run containers without managing servers. We set up a sample Node.js application, create a Docker image, push it to Amazon ECR, and deploy it on ECS using Fargate.

## Tools Used
- AWS ECS (Elastic Container Service): To manage and run Docker containers.
- AWS Fargate: For serverless container deployment.
- Amazon ECR (Elastic Container Registry): For storing Docker images.
- Docker: For building the application image.
- Node.js and Express: For the sample web application.
- AWS CloudWatch: For monitoring container logs.

## Step-by-Step Guide

### Step 1: Set Up the Docker Environment
1. Install Docker: If Docker is not installed, download Docker Desktop from the official website.
2. Verify Docker installation with:
    ```bash
    docker --version
    ```

### Step 2: Create a Dockerized Web Application
1. Create a Simple Web Application:
    ```bash
    mkdir ecs-demo-app
    cd ecs-demo-app
    npm init -y
    npm install express
    ```

2. Create an `app.js` file with the following content:
    ```javascript
    const express = require('express');
    const app = express();
    const port = 3000;

    app.get('/', (req, res) => {
      res.send('Hello from AWS ECS!');
    });

    app.listen(port, () => {
      console.log(`App running on port ${port}`);
    });
    ```

### Step 3: Create a Dockerfile
1. Create a `Dockerfile`:
    ```Dockerfile
    FROM node:14
    WORKDIR /app
    COPY . /app
    RUN npm install
    EXPOSE 3000
    CMD ["node", "app.js"]
    ```

### Step 4: Build and Test the Docker Container
1. Build the Docker image:
    ```bash
    docker build -t ecs-demo-app .
    ```

2. Run the container locally:
    ```bash
    docker run -p 3000:3000 ecs-demo-app
    ```

3. Test the app by opening `http://localhost:3000`.

### Step 5: Push the Docker Image to Amazon ECR
1. Create an ECR repository in AWS and name it `ecs-demo-app`.
2. Authenticate Docker to push to Amazon ECR:
    ```bash
    aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
    ```

3. Tag and push the Docker image:
    ```bash
    docker tag ecs-demo-app:latest <account-id>.dkr.ecr.<region>.amazonaws.com/ecs-demo-app:latest
    docker push <account-id>.dkr.ecr.<region>.amazonaws.com/ecs-demo-app:latest
    ```

### Step 6: Create ECS Cluster and Task Definition
1. Create an ECS Cluster in the AWS Console named `ecs-demo-cluster`.
2. Create a Fargate task definition with the image from ECR:
    - Use the JSON file provided (`ecs_task_definition.json`) or create manually in the console.

### Step 7: Run the Task and Access the Application
1. Run the task in the ECS cluster.
2. Find the public IP in the task details and visit `http://<public-ip>:3000` to verify.

### Troubleshooting
- Ensure security groups allow inbound traffic on port 3000.
- Ensure tasks run in a public subnet with internet access.

### Conclusion
This project outlines the steps to deploy a Dockerized web application on AWS ECS with Fargate, covering Docker setup, ECR, ECS, and deploying the application.
