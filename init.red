Red [
    Title: "esa.red --- Interface to esa.io"
    Author: "Nab Inno <nab@blahfe.com>"
    URL: https://github.com/nabinno/esa.red
    Date: 24-March-2019
    Version: 0.0.1
    Red: "~> 0.6.4"
    Keyworeds: [tools esa]
    Commentary: {
        Get the Personal API Access Token from https://{{yourteam}}.esa.io/user/applications

        @todo
        - Add Esa-Component-Config
        - Apply ESA-DISPLAY-DATE-FORMAT
        - Add ESA-TOKENS-AND-TEAM-NAMES config
        - Encrypt risky configs
    }
]

do/args %require [red-elixir json http-tools marky-mark]

do %esa-api-client.red
do %esa-service-list.red
do %esa-service-create.red
do %esa-service-update.red
do %esa-service-delete.red
do %esa-component-index.red
do %esa-component-new.red
do %esa-component-edit.red
do %esa.red

ESA-DISPLAY-DATE-FORMAT: "%Y-%m-%d %H:%M"
ESA-NUMBER-OF-LIST-PER-PAGE: either exists? %esa.conf [select load %esa.conf 'ESA-NUMBER-OF-LIST-PER-PAGE][ask "Please, type your Esa number of list per page: "]
ESA-TEAM-NAME: either exists? %esa.conf [select load %esa.conf 'ESA-TEAM-NAME][ask "Please, type your Esa team name: "]
ESA-TOKEN: either exists? %esa.conf [select load %esa.conf 'ESA-TOKEN][ask "Please, type your Esa token (you can get one at https://{{your-team}}.esa.io/user/applications): "]
unless exists? %esa.conf [
    save %esa.conf compose [
        ESA-TOKEN: (ESA-TOKEN)
        ESA-TEAM-NAME: (ESA-TEAM-NAME)
        ESA-NUMBER-OF-LIST-PER-PAGE: (ESA-NUMBER-OF-LIST-PER-PAGE)
    ]
]

Esa/init
