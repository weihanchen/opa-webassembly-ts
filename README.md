OPA WebAssembly Typescript Demo
===

## Install OPA binary on Linux

```sh
curl -L -o opa https://openpolicyagent.org/downloads/v0.29.4/opa_linux_amd64
mv opa /usr/local/bin
chmod 755 /usr/local/bin/opa
opa -h
```

## Install dependencies
```sh
npm install
```

## Create Ploicy

```rego
package rbac.authz

import data.rbac.authz.acl
import input

default allow = false
allow {
	# list of roles for input user
    roles := acl.user_roles[input.user]

    # for each role
    r := roles[_]

    # lookup the permissions list for role
    permissions := acl.role_permissions[r]

    # for each permission
    p := permissions[_]

    # check permission
    p == {"action": input.action, "object": input.object }
}
```

## Build .wasm binary

```sh
opa build -t wasm -e 'rbac.authz/hello' ./rbac.authz.rego && tar -xzf ./bundle.tar.gz /policy.wasm
# or npm run build
```

## Run the example code that invokes the Wasm binary
```sh
npm start -- '{\"input\":{\"user\":\"UserA\",\"object\":\"article\",\"action\":\"edit\"}}'
```