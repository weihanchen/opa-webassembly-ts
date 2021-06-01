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

```go
package rbac.authz

import data.rbac.authz.acl
import input

default allow = false
allow {
	# 將user所擁有的角色整理起來
    roles := acl.user_roles[input.user]

    # 對每一個角色進行處理
    r := roles[_]

    # 取出每個角色擁有哪些操作權限
    permissions := acl.role_permissions[r]

    # 準備對每一個權限進行檢查
    p := permissions[_]

    # 檢查權限是否與請求的功能、操作相互匹配
    p == {"action": input.action, "object": input.object }
}
```

## Build .wasm binary

```sh
opa build -t wasm -e 'rbac.authz/hello' ./rbac.authz.rego && tar -xzf ./bundle.tar.gz /policy.wasm
# or npm run build
```