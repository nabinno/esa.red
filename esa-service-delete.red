Red []

Esa-Service-Delete: context [
    call: function [number][
        url-data: rejoin ["posts/" number]
        Esa-Api-Client/request/delete url-data "Delete" #()
    ]
]
