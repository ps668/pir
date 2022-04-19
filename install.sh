#!/bin/bash
echo "Phantom Installer"
echo "By: Phantom Development Team"
echo "Get Version..."

${curl} -s http://116.63.153.201/zygisk/version.txt > ${path}/version.txt
version=`cat ${path}/version.txt`
echo "Version: $version"

echo "Downloading..."
${curl} --progress-bar http://116.63.153.201/zygisk/module/$version.jar --output ${path}/$version.zip

echo "\nUnzipping..."
if [ ! -d "${path}/tmp" ];then
   mkdir -p "${path}/tmp"
fi
unzip -o ${path}/$version.zip -d ${path}/tmp

echo "Resource Installing..."
cp ${path}/tmp/classes.dex /data/local/tmp/classes.dex
chmod 777 /data/local/tmp/classes.dex

cp -rf ${path}/tmp/lib/arm64-v8a/* ${cache}/
cp ${path}/$version.zip ${cache}/resources.jar
chmod 777 ${cache}/*

echo "Module Installing..."
magisk --install-module ${path}/tmp/assets/module.zip
