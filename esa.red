Red []

Esa: ctx [
    init: &[
        view/tight/no-wait template
        navigate index
        do-events
    ]

    template: layout [
        title "esa.red - main"
        .esa: panel 720x800 [] rate 1
    ]

    navigate: fn ['path /with args [series!] /reload][
        switch path [
            index [
                if Esa-Component-Index/RES == none or reload [
                    clear Esa-Component-Index/RES
                    set 'Esa-Component-Index/RES Esa-Service-List/call
                ]
                .esa/pane: layout/tight/only Esa-Component-Index/init
            ]
            search [
                if with [
                    query: first args
                    clear Esa-Component-Index/RES
                    set 'Esa-Component-Index/RES Esa-Service-List/call/search query
                    .esa/pane: layout/tight/only Esa-Component-Index/init
                ]
            ]
            new [
                .esa/pane: layout/tight/only Esa-Component-New/init
            ]
            edit [
                if with [
                    json: first args
                    set 'Esa-Component-Edit/JSON json
                    set 'Esa-Component-Edit/NAME json/name
                    set 'Esa-Component-Edit/CATEGORY json/category
                    set 'Esa-Component-Edit/TAGS json/tags
                    set 'Esa-Component-Edit/PROGRESS json/wip == false
                    set 'Esa-Component-Edit/UPDATED json/updated_at
                    set 'Esa-Component-Edit/URL json/url
                    set 'Esa-Component-Edit/NUMBER to-string json/number
                    set 'Esa-Component-Edit/BODY-MD json/body_md
                    .esa/pane: layout/tight/only Esa-Component-Edit/init
                ]
            ]
        ]
    ]
]
