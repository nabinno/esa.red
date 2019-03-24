Red []

Esa-Service-Create: context [
    call: func [name category tags body-md][
        Esa-Api-Client/request/post "posts" "Create" ~m[
            post: ~m[
                name: (name)
                body_md: (body-md)
                category: (category)
                message: "[skip notice]"
                tags: (tags)
                wip: true
            ]
        ]
    ]
]
