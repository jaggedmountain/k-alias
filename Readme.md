# k*alias

Alias scripts for making kubectl *smooth*.

So smooth you wont even *want* a gui!

## Overview

Drop them into `/usr/local/bin` or somewhere on your path.

If you organize your folders as `context/namespace`, then `kns` will switch contexts and namespace, making a pretty seamless transition between clusters.  (It matches the folder name to kubeconfig context using grep, so be not a good idea to have one context name as a substring of another!)

They are safe to run without arguments, and without any, will generally just list resources.

Confirmation prompts protect negative-change actions (uninstall, restart).

You don't have to provide full names for the `pod` argument; a unique portion of the name will suffice. (This is big part of the smoothness!)

(Except for container names.  If a pod has multiple containers you must specify the full container name. i.e. `pod:container`.  If container name is required, it should show you the valid options).

By default the tools operate on the first match. You may want to pass a regex name to grep just the resource you want; if so, wrap it in quotes.

```bash
$ krl
NAME                                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/one-somechart-api    1/1     1            1           27h
deployment.apps/one-somechart-ui     2/2     2            2           27h
deployment.apps/two-somechart-api    1/1     1            1           27h
deployment.apps/two-somechart-ui     2/2     2            2           27h

$ krl one
restart deployment.apps/one-somechart-api? [yN]

$ krl "one.*ui"
restart deployment.apps/one-somechart-ui? [yN]
```

## Usage

- kk: shortkey for kubectl
  - `$ kk get pod`

- kns: set context/namespace from path (or to arg)
  - `$ kns`
  - `$ kns staging`

- kls: list or describe a pod
  - `$ kls`
  - `$ kls pod`

- klg: log stream
  - `$ klg pod`
  - `$ klg pod -f`
  - `$ klg pod:container`

- kex: exec in container (default is bash)
  - `$ kex pod`
  - `$ kex pod sh`
  - `$ kex pod:container psql -U postgres`
  - `$ kex pod:container cat /html/index.html > out.html`

- krl: rollout (restart) a resource (deployment, daemonset, statefulset)
  - `$ krl name`

- kup: upload file to container
  - `$ kup filename pod`
  - `$ kup filename pod:/path`
  - `$ kup filename pod:container:`
  - `$ kup filename pod:container:/path`
  - invalid: `$ kup filename pod:container` (colon must follow container name)

- kdn: download file from pod
  - `$ kdn pod:/path/file.ext`
  - `$ kdn pod:/path/file.ext newfile.ext`
  - `$ kdn pod:/path/file.ext dst/`
  - `$ kdn pod:/path/file.ext dst/newfile.ext`
  - `$ kdn pod:container:/path/file.ext`

- kap: apply yaml folder/file
  - `$ $ kap configmap.yaml`
  - `$ $ kap ../utility`

- krm: delete a pod
  - `$ krm pod`

- hls: helm list
  - `$ hls`

- hin: helm install/upgrade with app.values.yaml
  - `$ hin app repo/chart`
  - `$ hin app repo/chart --set other.var=val`

- hun: helm uninstall (prompts for confirmation)
  - `$ hun app`

- aksme: initiate AKS device login
  - `$ aksme`
  - `$ aksme rg-name aks-name` (initial login)
