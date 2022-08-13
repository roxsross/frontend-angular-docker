#!/bin/bash
SRC_REPO=https://github.com/roxsross/frontend-angular-docker
SRC_DIR=frontend-angular-docker
IMG_NAME=$1
IMG_PORT=80
LOCAL_PORT=80

if [ -z $IMG_NAME ]; then
  echo -e "\n\e[1;31m The Arguments not exists, add Image Name"
  echo -e "\e[0m \n\n\n"
  exit 1
fi

# Clone website
rm -Rf temp
mkdir temp
cd temp
git clone ${SRC_REPO}
cd ${SRC_DIR}

PACKAGE_VERSION=$(cat package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g')

echo $PACKAGE_VERSION >version.txt
IMG=${IMG_NAME}:$(cat version.txt)
echo $IMG

# List docker ps
sudo docker ps
# Create new image
sudo docker build -t ${IMG} .

#validate 
sudo docker container ls

sudo docker rm -f ${IMG_NAME} 

# Launch website
sudo docker run --detach --rm \
    --name ${IMG_NAME} \
    --publish ${LOCAL_PORT}:${IMG_PORT} \
    ${IMG}

#process docker
sudo docker ps

rm -rf version.txt
cd
echo "delete temp"
rm -Rf temp
echo "finish"