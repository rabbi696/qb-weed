QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local playersProcessingCannabis = {}

RegisterServerEvent('os_drugs:pickedUpCannabis')
AddEventHandler('os_drugs:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	  if 	TriggerClientEvent("QBCore:Notify", src, "Picked up some Cannabis!!", "Success", 8000) then
		  Player.Functions.AddItem('cannabis', 1) ---- change this shit 
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "add")
	  end
  end)



RegisterServerEvent('os_drugs:processCannabis')
AddEventHandler('os_drugs:processCannabis', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.RemoveItem('marijuana', 1)----change this
		Player.Functions.AddItem('joint', 1)-----change this
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "remove")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'Joint Processed successfully', "success")                                                                         				
end)

RegisterServerEvent('os_drugs:processCannabisxD')
AddEventHandler('os_drugs:processCannabisxD', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.RemoveItem('cannabis', 1)----change this
		Player.Functions.AddItem('marijuana', 1)-----change this
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "remove")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'Marijuana Processed successfully', "success")                                                                         				
end)


function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('os_drugs:cancelProcessing')
AddEventHandler('os_drugs:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('QBCore_:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('os_drugs:onPlayerDeath')
AddEventHandler('os_drugs:onPlayerDeath', function(data)
	local src = source
	CancelProcessing(src)
end)

QBCore.Functions.CreateCallback('weed:process', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "cannabis" then
					cb(true)
			    else
					TriggerClientEvent("QBCore:Notify", src, "You do not have any Cannabis", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)

QBCore.Functions.CreateCallback('weed:processxD', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "marijuana" then
					cb(true)
			    else
					TriggerClientEvent("QBCore:Notify", src, "You do not have any marijuana", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)
