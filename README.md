# ci-test
Desplegar Drone en ECS EC2

1. Instalar ecs-cli
2. Configurar ecs-cli

```
ecs-cli configure profile --profile-name default --access-key $AWS_ACCESS_KEY_ID --secret-key $AWS_SECRET_ACCESS_KEY
```
    
3. Crear configuración para el cluster

```
ecs-cli configure --cluster drone --region us-east-1 --default-launch-type EC2 --config-name drone
```

4. Crear un cluster si no existe

```
ecs-cli up --keypair id_rsa --capability-iam --size 2 --instance-type t2.medium --cluster-config drone
```

5. Create el archivo docker-compose.yml

6. Desplegar el archivo compose en el cluster

```
ecs-cli compose --file docker-compose.yml up --create-log-groups --cluster-config drone
```

7.
