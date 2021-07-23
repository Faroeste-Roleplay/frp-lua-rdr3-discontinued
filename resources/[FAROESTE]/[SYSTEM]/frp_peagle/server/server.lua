local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local savedMensage = {}

RegisterServerEvent('FRP:PEAGLE:checkJOB')
AddEventHandler('FRP:PEAGLE:checkJOB', function()

end)


RegisterCommand(
    "peagle",
    function(source,args)
      local _source = source

      local User = API.getUserFromSource(_source)
      local Character = User:getCharacter()
      local Inventory = Character:getInventory()
    
    --  User:closeInventory()  
    local item = Inventory:getItemAmount("pigeonpost") 
  
    if item > 0 then
      local IdTarget = cAPI.prompt(_source, "ID do Destinatário:", "")
    
      if IdTarget == "" then
          return
      end
    
      local idcart = math.random(111,999)
      
      local tplayer = API.getUserFromUserId(parseInt(tonumber(IdTarget))):getSource()
    
      local Mensagem = cAPI.prompt(_source, "Mensagem:", "")
    
      if Mensagem == "" then
          return
      end
    
      TriggerClientEvent("FRP:PEAGLE:GetCoords", _source, tplayer, Mensagem)
      Inventory:removeItem("pigeonpost", 1)
    else
      TriggerClientEvent('FRP:TOAST:New', _source, "error", "Você não pussi uma pombo correio.")
    end
      --TriggerEvent("FRP:PEAGLE:newNote", -1, Mensagem, "CART"..idcart)
end)


RegisterNetEvent("FRP:PEAGLE:SendMessage")
AddEventHandler("FRP:PEAGLE:SendMessage", function(source)
  local _source = source

  local User = API.getUserFromSource(_source)
  local Character = User:getCharacter()
  local Inventory = Character:getInventory()

  User:closeInventory()

  Wait(1000)

  local IdTarget = cAPI.prompt(_source, "ID do Destinatário:", "")

  if IdTarget == "" then
      return
  end

  local idcart = math.random(111,999)
  
  local tplayer = API.getUserFromUserId(tonumber(IdTarget)):getSource()

  local Mensagem = cAPI.prompt(_source, "Mensagem:", "")

  if Mensagem == "" then
      return
  end

  TriggerClientEvent("FRP:PEAGLE:GetCoords", _source, tplayer, Mensagem)
  Inventory:removeItem(-1, "pigeonpost", 1)
  
  --TriggerEvent("FRP:PEAGLE:newNote", -1, Mensagem, "CART"..idcart)
end)

RegisterNetEvent("FRP:PEAGLE:ReceiveCoords")
AddEventHandler("FRP:PEAGLE:ReceiveCoords", function(coords, tplayer, Mensagem)
  TriggerClientEvent("FRP:PEAGLE:ReceiveMenssage", tplayer, coords, Mensagem)
end)

RegisterNetEvent("FRP:PEAGLE:LoadsNote")
AddEventHandler("FRP:PEAGLE:LoadsNote", function()
   TriggerClientEvent('FRP:PEAGLE:updateNotes', -1, savedMensage)
end)

RegisterNetEvent("FRP:PEAGLE:newNote")
AddEventHandler("FRP:PEAGLE:newNote", function(text, id)
      local import = {
        ["ID"] = ""..id.."",
        ["text"] = ""..text.."",
      }
      table.insert(savedMensage, import)
      TriggerEvent("FRP:PEAGLE:LoadsNote")
end)

RegisterNetEvent("FRP:PEAGLE:updateNote")
AddEventHandler("FRP:PEAGLE:updateNote", function(noteID, text)
  savedMensage[noteID]["text"]=text
  TriggerEvent("FRP:PEAGLE:LoadsNote")
end)


RegisterNetEvent("FRP:PEAGLE:AddPombo")
AddEventHandler("FRP:PEAGLE:AddPombo", function()
  local _source = source
  local User = API.getUserFromSource(_source)
  local Character = User:getCharacter()

  local Inventory = Character:getInventory()

  Inventory:addItem("pigeonpost", 1)
end)


RegisterNetEvent("FRP:PEAGLE:destroyNote")
AddEventHandler("FRP:PEAGLE:destroyNote", function(noteID)
  table.remove(savedMensage, noteID)
  TriggerEvent("FRP:PEAGLE:LoadsNote")
end)