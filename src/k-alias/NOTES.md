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
