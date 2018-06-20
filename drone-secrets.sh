#!/bin/bash
#title           :drone_secrets.sh
#description     :Registra los secretos requeridos por drone para cada uno de los repositorios activos
#author          :Luis Fernando Torres
#date            :2018-06-19
#version         :0.1
#usage           :none
#notes           :Busca los repositorio activos, borra los secretos de cada repositorio y los registra nuevamente
#notes           :El host debe tener instalado drone-cli
#bash_version    :
#==============================================================================

set -o xtrace

#variables dockerhub, el archivo .drone.yml debe contener la línea: secrets: [ docker_username, docker_password ]
DOCKER_USERNAME=XXXX
DOCKER_PASSWORD=XXXXXXXX
#variables aws, el archivo .drone.yml debe contener la línea: secrets: [ aws_access_key_id, aws_secret_access_key ]
AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXX
AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXX
#variables telegram, el archivo .drone.yml debe contener la línea: secrets: [ telegram_token, telegram_to ]
TELEGRAM_TO="XXXXXXX"
TELEGRAM_TOKEN="XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

#buscar los repositorio activos
repositorios=`drone repo ls`
echo repositorios
for repositorio in $repositorios
do
   #borrar todos los secretos
   drone secret rm --repository $repositorio --name DOCKER_USERNAME
   drone secret rm --repository $repositorio --name DOCKER_PASSWORD
   drone secret rm --repository $repositorio --name AWS_ACCESS_KEY_ID
   drone secret rm --repository $repositorio --name AWS_SECRET_ACCESS_KEY
   drone secret rm --repository $repositorio --name TELEGRAM_TO
   drone secret rm --repository $repositorio --name TELEGRAM_TOKEN
   #registrar los secretos
   drone secret add --image=plugins/docker --repository $repositorio --name=DOCKER_USERNAME --value=$DOCKER_USERNAME
   drone secret add --image=plugins/docker --repository $repositorio --name=DOCKER_PASSWORD --value=$DOCKER_PASSWORD
   drone secret add --image=plugins/s3 --repository $repositorio -name=AWS_ACCESS_KEY_ID --value=$AWS_ACCESS_KEY_ID
   drone secret add --image=plugins/s3 --repository $repositorio -name=AWS_SECRET_ACCESS_KEY --value=$AWS_SECRET_ACCESS_KEY
   drone secret add --image=appleboy/drone-telegram --repository $repositorio -name=TELEGRAM_TO --value=$TELEGRAM_TO
   drone secret add --image=appleboy/drone-telegram --repository $repositorio -name=TELEGRAM_TOKEN --value=$TELEGRAM_TOKEN
drone secret ls $repositorio
done
