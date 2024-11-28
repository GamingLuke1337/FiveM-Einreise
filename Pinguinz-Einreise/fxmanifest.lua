fx_version 'cerulean'
games { 'gta5' }

author 'Craniax - edited by Musiker15 and Gamingluke1337'
description 'Einreise Script'
version '4.0'

shared_scripts {
    'config.lua',
    'locales/*.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}