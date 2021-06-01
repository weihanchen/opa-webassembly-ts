package rbac.authz

import data
import input

default allow = false
allow {
	# list of roles for input user
    roles := data.user_roles[input.user]

    # for each role
    r := roles[_]

    # lookup the permissions list for role
    permissions := data.role_permissions[r]

    # for each permission
    p := permissions[_]

    # check permission
    p == {"action": input.action, "object": input.object }
}