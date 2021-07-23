local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local savedNotes = {
  
}
-- Não copia comédia!!!!!
TriggerEvent('VP:NOTEPAD:LoadsNote')

RegisterCommand('carta', function(source, args, user)
  local _source = source
  local User = API.getUserFromSource(_source)
  local Character = User:getCharacter()
  local Inventory = Character:getInventory()
  local item = Inventory:getItemAmount("notepad") 
  
  if item > 0 then
      TriggerClientEvent('VP:NOTEPAD:note', _source)
      TriggerClientEvent('VP:NOTEPAD:OpenNotepadGui', _source)
      TriggerEvent('VP:NOTEPAD:LoadsNote')
  else
      TriggerClientEvent('VP:TOAST:New', _source, "error", "Você não pussi uma carta.")
  end

end)


RegisterNetEvent("VP:NOTEPAD:LoadsNote")
AddEventHandler("VP:NOTEPAD:LoadsNote", function()
   TriggerClientEvent('VP:NOTEPAD:updateNotes', -1, savedNotes)
end)

RegisterNetEvent("VP:NOTEPAD:newNote")
AddEventHandler("VP:NOTEPAD:newNote", function(text, x, y, z)
      local import = {
        ["text"] = ""..text.."",
        ["x"] = x,
        ["y"] = y,
        ["z"] = z,
      }
      table.insert(savedNotes, import)
      TriggerEvent("VP:NOTEPAD:LoadsNote")
end)

RegisterNetEvent("VP:NOTEPAD:updateNote")
AddEventHandler("VP:NOTEPAD:updateNote", function(noteID, text)
  savedNotes[noteID]["text"]=text
  TriggerEvent("VP:NOTEPAD:LoadsNote")
end)

RegisterNetEvent("VP:NOTEPAD:destroyNote")
AddEventHandler("VP:NOTEPAD:destroyNote", function(noteID)
  table.remove(savedNotes, noteID)
  TriggerEvent("VP:NOTEPAD:LoadsNote")
end)

