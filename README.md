# Integración Continua (CI) con Drone sobre AWS

1. Creando una istancia EC2
    AMI centos 7
    Con Ip pública
 
2. En github 
    Crear un nuevo OAuth Apps en la organización
        Settings->OAuth Apps->New OAuth Apps
    
    
2. En la instancia EC2
    Agregar las siguientes líneas al archivo /home/centos/.bashrc
    
    ```
    #variables tomadas de github
    export DRONE_GITHUB_CLIENT=Client ID
    export DRONE_GITHUB_SECRET=Client Secret
    export DRONE_HOST=http://example.com
    export DRONE_SECRET=creado_en_drone_yml
    #variables tomadas del la interfaz gráfica de drone, settings->token
    export DRONE_SERVER=http://example.com
    export DRONE_TOKEN=obtenido_de_interfaz_done
    ```
    
    Instalar droker
    Instalar docker-compose
    crear archivo docker-compose.yml para drone
    Lanzar los contenedores del docker-compose.yml
    Verificar en el navegador
    
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
