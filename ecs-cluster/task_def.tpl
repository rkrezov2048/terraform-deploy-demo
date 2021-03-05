[
    {
        "name": "${ecs_service_name}",
        "image": "${image_url}",
        "cpu": ${cpu},
        "memory": ${memory},
        "essential": true,
        "portMappings": [
            {
                "hostPort": 0,
                "protocol": "tcp",
                "containerPort": ${containerPort}
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group" : "${ecs_service_name}-LogGroup",
                "awslogs-region": "${logs_region}",
                "awslogs-stream-prefix" : "${ecs_service_name}-LogGroup-stream"
            }
        }

    }
]