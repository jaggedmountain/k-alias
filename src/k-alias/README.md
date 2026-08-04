
# k*alias (k-alias)

Alias scripts for making kubectl smooth: kk, kns, kls, klg, kex, krl, kup, kdn, kap, krm, plus helm and Azure helpers.

## Example Usage

```json
"features": {
    "ghcr.io/jaggedmountain/k-alias/k-alias:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| installPath | Directory the alias scripts are installed into. Must be on PATH. | string | /usr/local/bin |
| includeKubectl | Install the kubectl aliases (kk, kns, kls, klg, kex, krl, kup, kdn, kap, krm). | boolean | true |
| includeHelm | Install the helm aliases (hls, hin, hun). | boolean | true |
| includeAzure | Install the Azure aliases (azs, aksme). | boolean | true |

## Usage

The scripts are plain bash and only need `kubectl` (and `helm` / `az` for the
helm and Azure aliases) on the PATH. Pair the feature with the tooling features:

```jsonc
"features": {
    "ghcr.io/devcontainers/features/kubectl-helm-minikube:1": {},
    "ghcr.io/devcontainers/features/azure-cli:1": {},
    "ghcr.io/jaggedmountain/k-alias/k-alias:1": {}
}
```

Skip the groups that aren't wanted:

```jsonc
"features": {
    "ghcr.io/jaggedmountain/k-alias/k-alias:1": {
        "includeHelm": false,
        "includeAzure": false
    }
}
```

Command reference lives in the [repo Readme](https://github.com/jaggedmountain/k-alias#usage).

## OS support

Any Linux base image with `bash` available.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/jaggedmountain/k-alias/blob/main/src/k-alias/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
