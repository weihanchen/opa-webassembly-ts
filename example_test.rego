package example
user_roles = {
      "moderator": ["manager"]
}

role_permissions = {
      "manager": [
        { "action": "edit", "object": "article" },
        { "action": "create", "object": "article" }
      ]
}

test_allow_edit_article {
    allow with input as {"user": "moderator", "action": "edit", "object": "article"} with data.user_roles as user_roles with data.role_permissions as role_permissions
}