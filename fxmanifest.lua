fx_version 'cerulean'
games { 'gta5' }

author 'More Than Code'
description 'MTC polaroid resource'

shared_scripts {
	'shared/*.lua'
}

client_scripts {
    'client/main.lua',
    'client/camera.lua'
}

server_scripts {
    'server/main.lua',
}

ui_page 'html/index.html'


files {
    'html/*.html',
    'html/*.css',
    'html/*.js',
}
