fx_version 'cerulean'
games { 'rdr3', 'gta5' }

lua54 'yes'

ui_page 'html/index.html'

files {
    "html/index.html",
    "html/style/style.css",
    "html/script/index.js",
    "html/script/modules/*.js",
    "html/sound/*.mp3",
    "html/images/*.png",
}

shared_scripts {
    "shared/_input.lua",
}

server_scripts {
    "server/_main.lua",
}

client_scripts {
    "client/_main.lua",
}
shared_script '@believer/modules/Anticheat/shared/_trigger.lua'