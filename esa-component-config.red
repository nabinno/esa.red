Red []

Esa-Component-Config: context [
    TEAM-NAME: none TOKEN: none

    init: function [][
        out: ~c[
            field (either exists? %esa.conf [select load %esa.conf 'ESA-TEAM-NAME][""]) 360x24 on-change [set 'TEAM-NAME face/text] hint "Team name" return
            field (either exists? %esa.conf [select load %esa.conf 'ESA-TOKEN][""]) 360x24 on-change [set 'TOKEN face/text] hint "Token" return
            text "Get the Personal API Access Token from https://{{yourteam}}.esa.io/user/applications" return
            button "Set" [.on-set-config]
        ]
        ~c[across space 0x0 panel [(out)]]
    ]

    .on-set-config: does [
        set 'ESA-TEAM-NAME TEAM-NAME
        set 'ESA-TOKEN TOKEN
        unless exists? %esa.conf [
            save %esa.conf ~c[
                ESA-TOKEN: (ESA-TOKEN)
                ESA-TEAM-NAME: (ESA-TEAM-NAME)
            ]

        ]
        Esa/navigate/reload "/index"
    ]
]
