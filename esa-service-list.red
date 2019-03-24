Red []

Esa-Service-List: context [
    call: func [/search query][
        Esa-Api-Client/request/get "posts" "List" either search [
            ~m[per_page: ESA-NUMBER-OF-LIST-PER-PAGE q: (query)]
        ][
            ~m[per_page: ESA-NUMBER-OF-LIST-PER-PAGE]
        ]
    ]
]
