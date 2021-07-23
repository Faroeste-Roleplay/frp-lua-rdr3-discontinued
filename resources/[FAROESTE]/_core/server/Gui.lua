local prompts = {}
function API.prompt(source,title,default_text)
	local r = async()
    prompts[source] = r
	cAPI._prompt(source,title,default_text)
	return r:wait()
end

function cAPI.promptResult(text)
	if text == nil then
		text = ""
	end

	local prompt = prompts[source]
	if prompt ~= nil then
		prompts[source] = nil
		prompt(text)
	end
end