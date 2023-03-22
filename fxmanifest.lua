fx_version 'cerulean'
game 'gta5'
name 'hyon_mining'
version      '1.1.0'
description 'Mining'

lua54 'yes'

shared_script 'config.lua'

client_scripts {
	'@es_extended/imports.lua',
    'client/main.lua'
}

server_scripts {
	'@es_extended/imports.lua',
    'server/main.lua'
}

dependency 'es_extended'