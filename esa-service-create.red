Red []

Esa-Service-Create: ctx [
    call: fn [name category tags body-md][
        res: Esa-Api-Client/request/post "posts" "Create" ~m[
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
