package example
user_roles = {
      "userA": ["editor"]
}

role_permissions = {
      "editor": [
        { "action": "edit", "object": "article" },
        { "action": "create", "object": "article" }
      ]
}

test_allow_edit_article {
    allow with input as {"user": "userA", "action": "edit", "object": "article"} with data.user_roles as user_roles with data.role_permissions as role_permissions
    not allow with input as {"user": "not exists", "action": "edit", "object": "article"} with data.user_roles as user_roles with data.role_permissions as role_permissions
    not allow with input as {"user": "userA", "action": "edit", "object": "management"} with data.user_roles as user_roles with data.role_permissions as role_permissions
}

test_allow_create_article {
    allow with input as {"user": "userA", "action": "create", "object": "article"} with data.user_roles as user_roles with data.role_permissions as role_permissions
    not allow with input as {"user": "not exists", "action": "create", "object": "article"} with data.user_roles as user_roles with data.role_permissions as role_permissions
    not allow with input as {"user": "userA", "action": "create", "object": "management"} with data.user_roles as user_roles with data.role_permissions as role_permissions
}