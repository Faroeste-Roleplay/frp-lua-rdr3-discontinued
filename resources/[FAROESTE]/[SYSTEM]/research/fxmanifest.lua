fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	'@_core/lib/utils.lua',
	'client.lua',
	'client_js.js',
}

-- server_scripts {
-- 	'@_core/lib/utils.lua',
-- 	'server.lua'
-- }

exports {
	'DataViewNativeGetEventData',
	'DataViewNativeGetScenarioPointsCloseToCoords',
	'NativeCreateComposite',
	'NativeGetCompositeEntities',
	'DataViewNetowrk',
	'GET_TASK_FISHING_DATA',
	'SET_TASK_FISHING_DATA',
	'N_0x04019AE4956D4393',
}
