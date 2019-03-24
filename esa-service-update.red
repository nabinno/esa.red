Red []

Esa-Service-Update: ctx [
    call: fn [
        post-number
        /name name-data /category category-data /tags tags-data /body-md body-md-data
        /wip /skip-notice
    ][
        Esa-Api-Client/request/patch rejoin ["posts/" post-number] "Update esa" case [
            body-md [~m[post: ~m[
                        body_md: (body-md-data)
                        wip: (either wip [true][false])
                        message: (either skip-notice ["[skip notice]"][""])
            ]]]
            tags [~m[post: ~m[
                        tags: (vconcat (split-string tags-data))
                        message: "[skip notice]"
            ]]]
            category [~m[post: ~m[
                        category: (category-data)
                        message: "[skip notice]"
            ]]]
            name [~m[post: ~m[
                        name: (name-data)
                        message: "[skip notice]"
            ]]]
        ]
    ]

    call-with-body-md-command: fn [number body-md][call/body-md number body-md]

    call-with-body-md-wip-command: fn [number body-md][call/body-md/wip number body-md]

    call-with-body-md-skip-notice-command: fn [number body-md][call/body-md/skip-notice number body-md]
]
