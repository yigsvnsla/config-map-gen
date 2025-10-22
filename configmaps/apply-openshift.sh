#!/bin/bash
# Script para aplicar todos los ConfigMaps y el deployment actualizado en OpenShift
# Asegúrate de estar logueado: oc login

NAMESPACE="bb-dev-otc"

echo "🔍 Verificando namespace..."
oc project $NAMESPACE

echo ""
echo "📦 Aplicando ConfigMaps..."
oc apply -f aguabl-configmap.yml -n $NAMESPACE
oc apply -f atm-configmap.yml -n $NAMESPACE
oc apply -f avanceefectivo-configmap.yml -n $NAMESPACE
oc apply -f belcorp-configmap.yml -n $NAMESPACE
oc apply -f broadnet-configmap.yml -n $NAMESPACE
oc apply -f cep-configmap.yml -n $NAMESPACE
oc apply -f clarocp-configmap.yml -n $NAMESPACE
oc apply -f clarop-configmap.yml -n $NAMESPACE
oc apply -f claror-configmap.yml -n $NAMESPACE
oc apply -f clarotv-configmap.yml -n $NAMESPACE
oc apply -f cnel-configmap.yml -n $NAMESPACE
oc apply -f cnt-configmap.yml -n $NAMESPACE
oc apply -f costotransaccion-configmap.yml -n $NAMESPACE
oc apply -f creditia-configmap.yml -n $NAMESPACE
oc apply -f cte-configmap.yml -n $NAMESPACE
oc apply -f cvialco-configmap.yml -n $NAMESPACE
oc apply -f depenlinea-configmap.yml -n $NAMESPACE
oc apply -f depositoespecial-configmap.yml -n $NAMESPACE
oc apply -f deposito-configmap.yml -n $NAMESPACE
oc apply -f deprati-configmap.yml -n $NAMESPACE
oc apply -f deptemp-configmap.yml -n $NAMESPACE
oc apply -f directvpospago-configmap.yml -n $NAMESPACE
oc apply -f directvpre-configmap.yml -n $NAMESPACE
oc apply -f ecuaquimica-configmap.yml -n $NAMESPACE
oc apply -f ecut-configmap.yml -n $NAMESPACE
oc apply -f educacion-configmap.yml -n $NAMESPACE
oc apply -f etapa-configmap.yml -n $NAMESPACE

echo ""
echo "🔄 Verificando ConfigMaps creados..."
oc get configmap aguabl -n $NAMESPACE
oc get configmap atm -n $NAMESPACE
oc get configmap avanceefectivo -n $NAMESPACE
oc get configmap belcorp -n $NAMESPACE
oc get configmap broadnet -n $NAMESPACE
oc get configmap cep -n $NAMESPACE
oc get configmap clarocp -n $NAMESPACE
oc get configmap clarop -n $NAMESPACE
oc get configmap claror -n $NAMESPACE
oc get configmap clarotv -n $NAMESPACE
oc get configmap cnel -n $NAMESPACE
oc get configmap cnt -n $NAMESPACE
oc get configmap costotransaccion -n $NAMESPACE
oc get configmap creditia -n $NAMESPACE
oc get configmap cte -n $NAMESPACE
oc get configmap cvialco -n $NAMESPACE
oc get configmap depenlinea -n $NAMESPACE
oc get configmap depositoespecial -n $NAMESPACE
oc get configmap deposito -n $NAMESPACE
oc get configmap deprati -n $NAMESPACE
oc get configmap deptemp -n $NAMESPACE
oc get configmap directvpospago -n $NAMESPACE
oc get configmap directvpre -n $NAMESPACE
oc get configmap ecuaquimica -n $NAMESPACE
oc get configmap ecut -n $NAMESPACE
oc get configmap educacion -n $NAMESPACE
oc get configmap etapa -n $NAMESPACE

echo ""
echo "🚀 Aplicando deployment actualizado..."
oc apply -f deployment-updated.yml -n $NAMESPACE

echo ""
echo "⏳ Esperando rollout del deployment..."
oc rollout status deployment/otc-core -n $NAMESPACE

echo ""
echo "📊 Estado de los pods:"
oc get pods -l app=otc-core -n $NAMESPACE

echo ""
echo "✅ ¡Despliegue completado!"
echo ""
echo "💡 Comandos útiles:"
echo "   Ver logs: oc logs -f deployment/otc-core -n $NAMESPACE"
echo "   Ver ConfigMaps: oc get configmaps -n $NAMESPACE | grep -E \"rms-|otro-\""
echo "   Entrar al pod: oc rsh deployment/otc-core -n $NAMESPACE"
echo "   Verificar archivos montados: oc rsh deployment/otc-core ls -la /deployments/xslt_desa"