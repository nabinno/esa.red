Red [
    Title: "esa.red --- Interface to esa.io"
    Author: "Nab Inno <nab@blahfe.com>"
    URL: https://github.com/nabinno/esa.red
    Date: 24-March-2019
    Version: 0.0.1
    Red: "~> 0.6.4"
    Keywords: [tools esa]
    Commentary: {
        Get the Personal API Access Token from https://{{yourteam}}.esa.io/user/applications

        @todo
        - Add Esa-Component-Config
        - Apply ESA-DISPLAY-DATE-FORMAT
        - Add ESA-TOKENS-AND-TEAM-NAMES config
        - Encrypt risky configs
    }
    Needs: View
]

#include %mods/github.com/nabinno/red-elixir/init.red
#include %mods/github.com/rebolek/red-tools/json.red
#include %mods/github.com/nabinno/red-tools/http-tools.red
#include %esa-api-client.red
#include %esa-service-list.red
#include %esa-service-create.red
#include %esa-service-update.red
#include %esa-service-delete.red
#include %esa-component-index.red
#include %esa-component-new.red
#include %esa-component-edit.red
#include %esa-component-config.red
#include %esa.red

ESA-DISPLAY-DATE-FORMAT: "%Y-%m-%d %H:%M"
ESA-NUMBER-OF-LIST-PER-PAGE: 20
ESA-TEAM-NAME: none
ESA-TOKEN: none

Esa/init
