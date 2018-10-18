#!/bin/bash

DEPLOY_ENV=$1
envs=(dev staging prod)
match=""
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"



if [ -z "${DEPLOY_ENV}" ]; then
	echo "please spesify deploy env, ex: init.sh prod"
	exit 1
fi

for env in "${envs[@]}"
do

	if [ "${DEPLOY_ENV}" == "$env" ]; then
		match='yes'
	fi
done

if [ -z "${match}" ]; then
	echo "wrong deploy env, deploy env must in : dev, staging, prod"
	exit 1
fi

export DEPLOY_ENV=$DEPLOY_ENV

#generate template
sed -e "s/DEPLOY_ENV/$DEPLOY_ENV/g" "${SCRIPTPATH}"/k8s-config-templates/um-api-migration.tmpl > "${SCRIPTPATH}"/um-api-migration.yaml
sed -e "s/DEPLOY_ENV/$DEPLOY_ENV/g" "${SCRIPTPATH}"/k8s-config-templates/um-api-seed.tmpl > "${SCRIPTPATH}"/um-api-seed.yaml
sed -e "s/DEPLOY_ENV/$DEPLOY_ENV/g" "${SCRIPTPATH}"/k8s-config-templates/um-api.tmpl > "${SCRIPTPATH}"/um-api.yaml



