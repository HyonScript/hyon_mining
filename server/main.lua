--ESX = nil

--if Config.UseESX then
 --   TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--end
local rocks ={}
local Time = (Config.RockSpawn*1000)
local ExchangeTime = (Config.Exchange_rate_refresh_time*100000)*36
local Exchange_rates = {}
ESX.RegisterServerCallback('mining:server:haspickaxe', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local PickaxeQuantity = xPlayer.getInventoryItem("pickaxe").count
    if PickaxeQuantity >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('lootmoney')
AddEventHandler('lootmoney', function(rock, id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local randomitem = math.random(1, #Config.Loots)
	local amount = 1
	local randomchance = math.random(1, 100)
--	for k,v in pairs (rock) do
	----print(v.spawn)
	----print(#rock)
	rocks[id].spawn = 0
--	--print(rocks[id].spawn)
--	end
	TriggerClientEvent("hyon_mining:create_rock", -1, rocks)
	----print(Config.Loots[randomitem].chance)
	--print(randomchance)
	--print(Config.Loots[randomitem].chance)
		if randomchance <= Config.Loots[randomitem].chance then
				if xPlayer.canCarryItem(Config.Loots[randomitem], amount) then
				xPlayer.addInventoryItem(Config.Loots[randomitem].item,amount)
				else
				xPlayer.showNotification(Config.Locales.nofreespace)
				end
		else
				if xPlayer.canCarryItem('stone', amount) then
				xPlayer.addInventoryItem('stone',amount)
				else
				xPlayer.showNotification(Config.Locales.nofreespace)
				end
		end
    --     xPlayer.showNotification('~o~You found ~g~money')
    end)
	
RegisterServerEvent('hyon_mining:get_rock')
AddEventHandler('hyon_mining:get_rock', function()
	----print("itt kapja meg hogy kell rock")
	TriggerClientEvent("hyon_mining:create_rock", -1, rocks)
    --     xPlayer.showNotification('~o~You found ~g~money')
    end)

RegisterServerEvent('hyon_mining:get_exchange')
AddEventHandler('hyon_mining:get_exchange', function()
	----print("itt kapja meg hogy kell rock")
	TriggerClientEvent("hyon_mining:create_exchanges", -1, Exchange_rates)
    --     xPlayer.showNotification('~o~You found ~g~money')
    end)	
	
Citizen.CreateThread(function() 
    while true do
				if #rocks ~= #Config.Rocks then
				for k,v in pairs(Config.Rocks) do
				rocks[k] = {}
				rocks[k] = {coords = v.coords, spawn = 60}
				----print(rocks[k].coords, rocks[k].spawn)
				end
				--TriggerClientEvent("hyon_mining:create_rock", rocks)
				end
				Citizen.Wait(1000)
	end
end)

RegisterNetEvent("hyon_mining:smelting", function(id, ore, amount_ore)
   local xPlayer = ESX.GetPlayerFromId(source)
   local item = ore
   local coal = "coal"
   local amount = tonumber(amount_ore)
   local coalamount = nil
   local bar = nil
	if item == "iron_ore" then
		bar = "iron_bar"
		coalamount = 1*amount
	elseif item == "silver_ore" then
		bar = "silver_bar"
		coalamount = 3*amount
	elseif item == "gold_ore" then
		bar = "gold_bar"
		coalamount = 5*amount
	end
	Citizen.Wait(500)
	--print(coalamount)
    if xPlayer.getInventoryItem(item) and xPlayer.getInventoryItem(item).count >= amount and xPlayer.getInventoryItem(coal) and xPlayer.getInventoryItem(coal).count >= coalamount then
        xPlayer.removeInventoryItem(item, amount)
		xPlayer.removeInventoryItem(coal, coalamount)
		xPlayer.addInventoryItem(bar, amount)
		xPlayer.showNotification(Config.Locales.smelted)
	else
	xPlayer.showNotification(Config.Locales.noores)
    end
end)
 

RegisterNetEvent("hyon_mining:sellbar", function(id, bar, amount_bar, price)
   local xPlayer = ESX.GetPlayerFromId(source)
   local item = bar
   local amount = tonumber(amount_bar)
   local barprice = price

	Citizen.Wait(500)
	--print(coalamount)
    if xPlayer.getInventoryItem(item) and xPlayer.getInventoryItem(item).count >= amount then
        xPlayer.removeInventoryItem(item, amount)
		xPlayer.addMoney(barprice*amount)
		xPlayer.showNotification(Config.Locales.sell)
	else
	xPlayer.showNotification(Config.Locales.nosell)
    end
end)

RegisterNetEvent("hyon_mining:pickaxebuy", function(id, amount_pickaxe)
   local xPlayer = ESX.GetPlayerFromId(source)
   local item = "pickaxe"
   local amount = tonumber(amount_pickaxe)
    if xPlayer.getMoney() >= Config.PickaxePrice*amount then
        xPlayer.removeMoney(Config.PickaxePrice*amount)
		xPlayer.addInventoryItem(item, amount)
		else
	xPlayer.showNotification(Config.Locales.nomoney)
    end
end)
 
Citizen.CreateThread(function() 
    while true do
				for k,v in pairs(rocks) do
				if v.spawn < 60 then
				rocks[k].spawn = v.spawn+1
				----print(rocks[k].spawn)
				--				--print(Time)
				end
				end
				Citizen.Wait(Time)
	
	end
end) 

Citizen.CreateThread(function() 
    while true do
				for k,v in pairs(Config.Exchange_rate) do
				local randomexchangerates = math.random(v.min, v.max)
				Exchange_rates[k] = {}
				Exchange_rates[k].item = v.item
				Exchange_rates[k].price = randomexchangerates
				end
				Citizen.Wait(ExchangeTime)
	
	end
end)



