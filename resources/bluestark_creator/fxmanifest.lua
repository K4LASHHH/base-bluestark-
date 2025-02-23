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
  'shared/*.lua',
}

client_scripts {
  'client/*.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua',
}