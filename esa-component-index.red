Red []

Esa-Component-Index: ctx [
    RES: none

    init: &[
        out: copy []
        append out [
            button "Reload" [.on-reload]
            text right "Search" field 220x24 on-enter [.on-search face/text]  hint "with Enter"
            text 245x24 "" button "New" [.on-goto-new] return
        ]
        foreach post RES/posts [append out ~c[(.__draw-post post) return]]
        ~c[across space 0x0 panel [(out)]]
    ]

    .__draw-post: fn [post [map!]][
        out: copy [] data: .__simplify-post post
        append out ~c[
            button "Edit" [.on-goto-edit (post)]
            text (data .[Series/map d [rejoin [d "  "]] |> rejoin])
        ]
    ]

    .__simplify-post: fn [post [map!]][
        number: to-string post/number updated-at: post/updated_at full-name: post/full_name
        progress: either post/wip == true ["WIP"]["Ship"]
        ~c[(number) (updated-at) (progress) (any [full-name ""])]
    ]

    .on-goto-edit: fn [post][Esa/navigate/with edit ~c[(post)]]

    .on-goto-new: &[Esa/navigate new]

    .on-search: fn [query][Esa/navigate/with search ~c[(query)]]

    .on-reload: &[Esa/navigate/reload index]
]
