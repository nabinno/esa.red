Red []

Esa-Component-New: ctx [
    JSON: none NAME: none CATEGORY: none TAGS: none BODY-MD: none

    init: &[
        out: ~c[
            button "To Index" [.on-goto-index]
            field 150x24 on-change [set 'NAME face/text] hint "Name"
            field 150x24 on-change [set 'CATEGORY face/text] hint "Category"
            field 150x24 on-change [set 'TAGS face/text] hint "Tags" return
            area 720x620 on-change [set 'BODY-MD face/text] hint "Body with markdown" return
            button "Create" [.on-create-esa]
        ]
        ~c[across space 0x0 panel [(out)]]
    ]

    .on-goto-index: &[Esa/navigate index]

    .on-create-esa: &[
        Esa-Service-Create/call NAME CATEGORY TAGS BODY-MD
        Esa/navigate/reload index
    ]
]
