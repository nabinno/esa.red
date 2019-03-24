Red []

Esa-Component-Edit: context [
    JSON: none NAME: none CATEGORY: none TAGS: none PROGRESS: none UPDATED: none URL: none NUMBER: none BODY-MD: none

    init: function [][
        out: ~c[
            button "To Index" [.on-goto-index]
            text (NUMBER) text (UPDATED) text (either PROGRESS ["Ship"]["WIP"]) text (URL) return
            field (either NAME [NAME][""]) on-enter [.on-update-name face/text (JSON/number)] hint "Name w/ Enter"
            field (either CATEGORY [CATEGORY][""]) on-enter [.on-update-category face/text (JSON/number)] hint "Cat w/ Enter"
            field (either TAGS == [] [""][TAGS]) on-enter [.on-update-tags (JSON) (JSON/number)] hint "Tags w/ Enter" return
            area 240.240.240 (either BODY-MD == "" [""][BODY-MD]) 720x620 on-change [set 'BODY-MD face/text] return
            button "WIP" [.on-update-body-with-wip]
            button "Ship" [.on-update-body]
            button "Ship (notice)" [.on-update-body-with-notice]
            text 390x24 "" button "Delete" [.on-delete-esa]
        ]
        ~c[across space 0x0 panel [(out)]]
    ]

    .on-goto-index: does [Esa/navigate "/index"]

    .on-update-name: func [input-name repo][
        Esa-Service-Update/call/name repo input-name
    ]

    .on-update-category: func [input-category repo][
        Esa-Service-Update/call/category repo input-category
    ]

    .on-update-tags: func [input-tags repo /local tags][
        input-tags: String/_split input-tags " "
        Esa-Service-Update/call/tags repo input-tags
    ]

    .on-update-body: does [
        Esa-Service-Update/call-with-body-md-skip-notice-command JSON/number BODY-MD
    ]

    .on-update-body-with-notice: does [
        Esa-Service-Update/call-with-body-md-wip-command JSON/number BODY-MD
    ]

    .on-update-body-with-wip: does [
        Esa-Service-Update/call-with-body-md-wip-command JSON/number BODY-MD
    ]

    .on-delete-esa: does [
        Esa-Service-Delete/call JSON/number
        Esa/navigate/reload "/index"
    ]
]
