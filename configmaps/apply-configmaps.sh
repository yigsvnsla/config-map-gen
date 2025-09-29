#!/bin/bash
# Script para aplicar todos los ConfigMaps generados

kubectl apply -f rms-test-configmap.yml
kubectl apply -f rms-prueba-configmap.yml
