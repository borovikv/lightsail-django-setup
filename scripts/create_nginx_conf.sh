#!/bin/bash

PROJECT_NAME=$1
TEMPLATE_PATH="../lightsail-django-setup/config/nginx_template.conf"
sed "s|{{PROJECT_NAME}}|$PROJECT_NAME|g" "$TEMPLATE_PATH"