local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local savedNotes = {
  
}
-- Não copia comédia!!!!!
TriggerEvent('FRP:NOTEPAD:LoadsNote')

RegisterCommand('carta', function(source, args, user)
  local _source = source
  local User = API.getUserFromSource(_source)
  local Character = User:getCharacter()
  local Inventory = Character:getInventory()
  local item = Inventory:getItemAmount("notepad") 
  
  if item > 0 then
      TriggerClientEvent('FRP:NOTEPAD:note', _source)
      TriggerClientEvent('FRP:NOTEPAD:OpenNotepadGui', _source)
      TriggerEvent('FRP:NOTEPAD:LoadsNote')
  else
      TriggerClientEvent('FRP:TOAST:New', _source, "error", "Você não pussi uma carta.")
  end

end)


RegisterNetEvent("FRP:NOTEPAD:LoadsNote")
AddEventHandler("FRP:NOTEPAD:LoadsNote", function()
   TriggerClientEvent('FRP:NOTEPAD:updateNotes', -1, savedNotes)
end)

RegisterNetEvent("FRP:NOTEPAD:newNote")
AddEventHandler("FRP:NOTEPAD:newNote", function(text, x, y, z)
      local import = {
        ["text"] = ""..text.."",
        ["x"] = x,
        ["y"] = y,
        ["z"] = z,
      }
      table.insert(savedNotes, import)
      TriggerEvent("FRP:NOTEPAD:LoadsNote")
end)

RegisterNetEvent("FRP:NOTEPAD:updateNote")
AddEventHandler("FRP:NOTEPAD:updateNote", function(noteID, text)
  savedNotes[noteID]["text"]=text
  TriggerEvent("FRP:NOTEPAD:LoadsNote")
end)

RegisterNetEvent("FRP:NOTEPAD:destroyNote")
AddEventHandler("FRP:NOTEPAD:destroyNote", function(noteID)
  table.remove(savedNotes, noteID)
  TriggerEvent("FRP:NOTEPAD:LoadsNote")
end)

