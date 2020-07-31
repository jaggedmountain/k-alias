#!/bin/bash
# - krl: rollout a resource (deployment, daemonset, statefulset)
#   - example: `krl name`

if [ -z "$1" ]; then
  kubectl get deployment,daemonset,statefulset
  exit
fi

resource=`kubectl get deployment,daemonset,statefulset | grep "$1" | head -n1 | awk '{print $1}'`


if [ -z "$resource" ]; then
  echo no resource found.
  exit
fi

read -rsn1 -p "restart $resource? [yN]" confirm
echo "..."

if [ "$confirm" == "y" ]; then
  kubectl rollout restart $resource
else
  echo canceled.
fi
