# Integración Continua (CI) con Drone sobre AWS ECS

Desplegando Drone en AWS Elactic Container Service (ECS);  launch-type EC2

1. Instalando ecs-cli en linux

```
sudo curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
```

2. Configurando ecs-cli

```
ecs-cli configure profile --profile-name default --access-key $AWS_ACCESS_KEY_ID --secret-key $AWS_SECRET_ACCESS_KEY
```

3. Creando configuración para el cluster

```
ecs-cli configure --cluster drone --region us-east-1 --default-launch-type EC2 --config-name drone
```

4. Creando un cluster; si no existe

```
ecs-cli up --keypair id_rsa --capability-iam --size 2 --instance-type t2.medium --cluster-config drone
```

5. Creando el archivo docker-compose.yml

    El archivo se encuentra en este repositorio

6. Desplegando el archivo docker-compose.yml en el cluster

```
ecs-cli compose --file docker-compose.yml up --create-log-groups --cluster-config drone
```
Esto crea el contenedor con docker-server y docker-agent

Para verificar que se están ejecutando

```
ecs-cli ps
```

7. Creando el servicio

Primero detener los contanedores que se están ejecutando

```
ecs-cli compose --file docker-compose.yml down --cluster-config drone

```

Y luego se crea el servicio
```
ecs-cli compose --file docker-compose.yml service up --cluster-config drone
```
