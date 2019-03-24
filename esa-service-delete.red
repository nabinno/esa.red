Red []

Esa-Service-Delete: ctx [
    call: fn [number][
        url-data: rejoin ["posts/" number]
        Esa-Api-Client/request/delete url-data "Delete" #()
    ]
]
