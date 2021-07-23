resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

fx_version 'adamant'
game 'common'

ui_page('html/index.html') 

client_scripts {
    'client/functions.lua',
    'client/events.lua',
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/fonts/crock.ttf',
    'html/fonts/robotoslab.ttf',
    'html/img/*',
    'html/js/script.js',
    'html/js/jquery.min.js',
}

exports {
    'Progress',
    'ProgressWithStartEvent',
    'ProgressWithTickEvent',
    'ProgressWithStartAndTick'
}