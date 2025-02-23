fx_version "adamant"

game "gta5"

description "Believer"

lua54 "yes"
version "1.9.4"

ui_page "html/index.html"

files {
	"imports.lua",
	"locale.js",
    "html/**",

}

shared_scripts {
	"locale.lua",
	"locales/*.lua",

	"config.lua",
	"config.weapons.lua",
	"gmLoad.lua",
	"modules/**/shared/*.lua",
    "modules/**/shared/objects/*.lua",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"config.logs.lua",
	"server/common.lua",
	"server/modules/callback.lua",
	"server/classes/player.lua",
	"server/functions.lua",
	"server/onesync.lua",
	"server/paycheck.lua",

	"server/main.lua",

	"common/modules/*.lua",
	"common/functions.lua",
	"server/modules/actions.lua",

	"modules/**/server/objects/*.lua",
    "modules/**/server/*.lua",
}

client_scripts {
	"client/common.lua",
	"client/functions.lua",
	"client/wrapper.lua",
	"client/modules/callback.lua",

	"client/main.lua",
	
	"common/modules/*.lua",
	"common/functions.lua",

	"common/functions.lua",
	"client/modules/actions.lua",
	"client/modules/death.lua",
	"client/modules/scaleform.lua",
	"client/modules/streaming.lua",

	"dependencies/init.lua",
    "dependencies/menu/RageUI.lua",
    "dependencies/components/*.lua",
    "dependencies/menu/**/*.lua",

    "modules/**/client/objects/*.lua",
    "modules/**/client/*.lua",
}

dependencies {
	"/native:0x6AE51D4B",
	"oxmysql",
	"spawnmanager",
}