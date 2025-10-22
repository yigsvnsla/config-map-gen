#!/bin/bash
# Script de rollback para restaurar el deployment original

NAMESPACE="bb-dev-otc"

echo "⚠️  ROLLBACK: Restaurando deployment original..."
oc apply -f deployment-backup.yml -n $NAMESPACE

echo "⏳ Esperando rollout..."
oc rollout status deployment/otc-core -n $NAMESPACE

echo "✅ Rollback completado"