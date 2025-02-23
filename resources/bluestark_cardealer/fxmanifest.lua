fx_version "adamant"
game "gta5"
lua54 'yes'

files {
    'index.html',
    'vue.js',
    'assets/**/*.*'
}

ui_page "index.html"

shared_scripts { 
    'shared/*.lua',
}

client_scripts { 
    "client/*.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua",
}