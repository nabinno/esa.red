Red []

Esa-Component-Index: context [
    RESPONSE: none

    init: func [/local out][
        out: copy []
        append out [
            button "Reload" [.on-reload]
            text right "Search" field 220x24 on-enter [.on-search face/text]  hint "with Enter"
            text 235x24 "" button "New" [.on-goto-new] return
        ]
        foreach post RESPONSE/posts [append out ~c[(.__draw-post post) return]]
        ~c[across space 0x0 panel [(out)]]
    ]

    .__draw-post: function [post [map!]][
        out: copy [] data: .__simplify-post post
        append out ~c[
            button "Edit" [.on-goto-edit (post)]
            text (data .[Series/map 'd [rejoin [d "  "]] |> rejoin])
        ]
    ]

    .__simplify-post: function [post [map!]][
        number: to-string post/number updated-at: post/updated_at full-name: post/full_name
        progress: either post/wip == true ["WIP"]["Ship"]
        ~c[(number) (updated-at) (progress) (any [full-name ""])]
    ]

    .on-goto-edit: func [post][Esa/navigate/with "/edit" ~c[(post)]]

    .on-goto-config: does [Esa/navigate "/config"]

    .on-goto-new: does [Esa/navigate "/new"]

    .on-search: func [query][Esa/navigate/with "/search" ~c[(query)]]

    .on-reload: does [Esa/navigate/reload "/index"]
]
