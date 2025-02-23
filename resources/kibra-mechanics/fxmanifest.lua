fx_version "bodacious"

game "gta5"

author "Kibra#9999"

description "Created by Kibra for 0RESMON"

version "1.1.0"

client_scripts {"client/cam.lua","client/colors.lua", "client/client.lua", "client/flatbed.lua", "client/mechanic.lua"}

server_scripts {"@mysql-async/lib/MySQL.lua","server/server.lua", "server/version.lua"}

shared_scripts {"config/config_prices.lua", "config/config_main.lua", "config/config_mechanics.lua", "config/config_functions.lua", "config/config_lang.lua"}

ui_page "web/index.html"

escrow_ignore {
    "config/config_main.lua",
    "config/config_lang.lua",
    "config/config_mechanics.lua",
    "config/config_prices.lua",
    "config/config_functions.lua",
    "client/colors.lua",
}

files {
	"web/index.html", 
	"web/main.js", 
	"web/main.css", 
	"web/img/*.png",
	"data/carcols_gen9.meta",
    "data/carmodcols_gen9.meta",
    "data/carmodcols.ymt",
    "stream/vehicle_paint_ramps.ytd"
}
	
data_file "CARCOLS_GEN9_FILE" "data/carcols_gen9.meta"
data_file "CARMODCOLS_GEN9_FILE" "data/carmodcols_gen9.meta"
data_file "FIVEM_LOVES_YOU_447B37BE29496FA0" "data/carmodcols.ymt"

lua54 "yes"

dependencies {
	'kibra-core',
}

