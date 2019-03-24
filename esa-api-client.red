Red []

Esa-Api-Client: ctx [
    request: fn [
        url-data callback-message
        /get get-data /post post-data /put put-data /patch patch-data /delete delete-data
    ][
        remaining-requests: 100 next-reset: (to-integer time/_now) - 1 res: none header: none
        method: case [get ['GET] post ['POST] patch ['PATCH] put ['PUT] delete ['DELETE]]
        params: case [get [get-data] delete [delete-data]]
        url: make-url compose [https://api.esa.io/v1/teams/ (ESA-TEAM-NAME) (url-data)]
        url: either params [rejoin [url "?" Map/to-query-string params]][url]
        Logger/info ["Send/method: " method " url: " url " add.data: " any [post-data put-data patch-data]]
        append header: clear [] [Accept: "application/json"]
        if any [post patch put] [
            insert header [Content-Type: "application/json;charset=UTF-8"]
            post-data: Json/encode any [post-data put-data patch-data]
        ]
        if all [remaining-requests < 2 0 < till-reset: next-reset - to-integer Time/_now] [
            Logger/info ["Rate limit reached. Waiting" till-reset "seconds..."]
            wait till-reset
        ]

        res: send-request/data/with/auth url method post-data header 'Bearer ESA-TOKEN

        if res/headers/X-RateLimit-Remaining [remaining-requests: to-integer res/headers/X-RateLimit-Remaining]
        if res/headers/X-RateLimit-Reset [ts: copy res/headers/X-RateLimit-Reset next-reset: to-integer (load ts) / 1000]
        switch/default res/code [
            200 [
                Logger/info [callback-message " succeeded (\\( ⁰⊖⁰)/)"] res/data
            ]
            401 [
                if res/data/error == "Unauthorized" [return none]
                now: to-integer Time/_now
                either next-reset >= now [
                    Logger/info ["Error 401: Need to wait for" next-reset - now "seconds."]
                    wait next-reset - now + 1
                    Logger/info "Wait over."
                    call: [request]
                    unless 'get == method [
                        call/1: to-path call/1
                        append call/1 method
                        append call data
                        if 'post == method [append call post-data]
                        if 'put == method [append call put-data]
                        if 'patch == method [append call patch-data]
                        if 'delete == method [append call delete-data]
                        do reduce probe call
                    ]
                ][
                    Logger/info [callback-message " failed (\\( ⁰⊖⁰)/)"]
                    Error/raise res/data/error
                ]
            ]
        ][
            Logger/info ["Return code: " res/code] res/data
        ]
        res/data
    ]
]
