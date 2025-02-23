fx_version 'adamant'

game 'gta5'

lua54 'yes'

ui_page 'dist/index.html'

files {
	'dist/**/*.*',
  'dist/**/**/*.*',
  'dist/**/**/**/*.*',
}

shared_scripts {
  '@believer/imports.lua',
  'shared/*.lua'
}

client_scripts {
  'Config.lua',
  'client/*.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'Config.lua',
  'server/*.lua'
}