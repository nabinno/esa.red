Red []

Esa: context [
    init: does [
        view/tight/no-wait template
        either exists? %esa.conf [
            __set-config
            navigate "/index"
        ][
            navigate "/config"
        ]
        do-events
    ]

    template: [
        title "esa.red"
        .esa: panel 720x800 [] rate 1
    ]

    navigate: function [path /with args [series!] /reload][
        switch path [
            "/index" [
                if Esa-Component-Index/RESPONSE == none or reload [
                    clear Esa-Component-Index/RESPONSE
                    set 'Esa-Component-Index/RESPONSE Esa-Service-List/call
                ]
                .esa/pane: layout/tight/only Esa-Component-Index/init
            ]
            "/search" [
                if with [
                    query: first args
                    clear Esa-Component-Index/RESPONSE
                    set 'Esa-Component-Index/RESPONSE Esa-Service-List/call/search query
                    .esa/pane: layout/tight/only Esa-Component-Index/init
                ]
            ]
            "/new" [
                .esa/pane: layout/tight/only Esa-Component-New/init
            ]
            "/edit" [
                if with [
                    json: first args
                    set 'Esa-Component-Edit/JSON json
                    set 'Esa-Component-Edit/NAME json/name
                    set 'Esa-Component-Edit/CATEGORY json/category
                    set 'Esa-Component-Edit/TAGS Series/to-string json/tags
                    set 'Esa-Component-Edit/PROGRESS json/wip == false
                    set 'Esa-Component-Edit/UPDATED json/updated_at
                    set 'Esa-Component-Edit/URL json/url
                    set 'Esa-Component-Edit/NUMBER to-string json/number
                    set 'Esa-Component-Edit/BODY-MD json/body_md
                    .esa/pane: layout/tight/only Esa-Component-Edit/init
                ]
            ]
            "/config" [
                .esa/pane: layout/tight/only Esa-Component-Config/init
            ]
        ]
    ]

    __set-config: function [][
        conf-file: load %esa.conf
        set 'ESA-NUMBER-OF-LIST-PER-PAGE select conf-file 'ESA-NUMBER-OF-LIST-PER-PAGE
        set 'ESA-TEAM-NAME select conf-file 'ESA-TEAM-NAME
        set 'ESA-TOKEN select conf-file 'ESA-TOKEN
    ]
]
