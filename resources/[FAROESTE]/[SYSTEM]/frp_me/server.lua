RegisterCommand(
	"me",
	function(source, args)
		-- local text = "* "
		-- for i = 1, #args do
		-- 	text = text .. " " .. args[i]
		-- end
		-- text = text .. " *"

		local message = table.concat(args, " ")

		TriggerClientEvent("VP:ME:DisplayAboveHeadText", -1, message, source)
	end
)
