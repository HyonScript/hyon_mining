local blip = nil
local blipsmelter = nil
local zoneblip = nil
local playerPed = PlayerPedId()
local playerPedCoords = GetEntityCoords(playerPed)
local ClientRocks = {}
local Objects = {}
local has_pickaxe = false
local mineActive = false
local IsPlayerConnected = false
local stoneprice = 1
local ironprice = 1
local silverprice = 1
local goldprice = 1
local diamondprice = 1

Citizen.CreateThread(function()
    --  zoneblip = AddBlipForRadius(Config.MiningBlipCoord)
    --  SetBlipColour(zoneblip, 1)
	if Config.miningblip == true then
    blip = AddBlipForCoord(Config.MiningBlipCoord)
        SetBlipSprite(blip, 78)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Locales.bliptext)
        EndTextCommandSetBlipName(blip)
	end
	if Config.smelterblip == true then
	blipsmelter = AddBlipForCoord(Config.SmelterCoord)
        SetBlipSprite(blipsmelter, 618)
        SetBlipDisplay(blipsmelter, 4)
        SetBlipScale(blipsmelter, 0.75)
        SetBlipColour(blipsmelter, 5)
        SetBlipAsShortRange(blipsmelter, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Locales.smelterbliptext)
        EndTextCommandSetBlipName(blipsmelter)
	end
	if Config.shopblip == true then
	shopblip = AddBlipForCoord(Config.Shop)
        SetBlipSprite(shopblip, 52)
        SetBlipDisplay(shopblip, 4)
        SetBlipScale(shopblip, 0.75)
        SetBlipColour(shopblip, 5)
        SetBlipAsShortRange(shopblip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Locales.smelterbliptext)
        EndTextCommandSetBlipName(shopblip)
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
  if resourceName == 'hyon_mining' then 
     IsPlayerConnected = true
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    IsPlayerConnected = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPlayerConnected == true then
            ESX.TriggerServerCallback('mining:server:haspickaxe', function(cb)
                if cb then
                    has_pickaxe = true
                else
                    has_pickaxe = false
                end
            end)
        end
        Citizen.Wait(5000)
    end
end)


function DrawText3D(x, y, z, text, font, color, scale)
	local defaultFont = 4
	local defaultColor = {r = 255, g = 255, b = 255}
	local defaultScale = 0.35
	if scale ~= nil then
		defaultScale = scale
	end
	if font ~= nil then
		defaultFont = font
	end
	if color ~= nil then
		defaultColor = color
	end
	SetTextScale(defaultScale, defaultScale)
    SetTextFont(defaultFont)
	SetTextProportional(1)
    SetTextColour(defaultColor.r, defaultColor.g, defaultColor.b, 255)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    --DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


Citizen.CreateThread(function()

     while true do

     Citizen.Wait(1)
       local ped = PlayerPedId()
	local playerPed = PlayerPedId()
       local mycords = GetEntityCoords(PlayerPedId())
      for i, locations in pairs(ClientRocks) do
	  local dist = #(mycords - locations.coords)
	  local mdl = GetHashKey("prop_rock_2_a")
	--  --print(i,"i:",Objects[i])
      if dist < 50 then
	  if locations.spawn == 60 then
		if Objects[i] == nil then
		Objects[i] = CreateObject(mdl, locations.coords.x, locations.coords.y, locations.coords.z-1.5, true, true, false)
		FreezeEntityPosition(Objects[i], true)
		end
	  -- DrawMarker(32, locations.coords.x, locations.coords.y, locations.coords.z , -1, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0, 80, true, true, 2, 0, 0, 0, 0)
   --    DrawText3Ds(locations.coords.x, locations.coords.y, locations.coords.z, "Press ~g~E~s~ to get rockure") 
	   if dist < 2 and mineActive == false then
	   DrawText3Ds(locations.coords.x, locations.coords.y, locations.coords.z, Config.Locales.loottext)
       if IsControlJustReleased(0,38) then
       --ClientRocks[i].spawn = 0
    --   FreezeEntityPosition(playerPed, true)
	--TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
	--Citizen.Wait(10000)
		--	        if loot[i].prop ~= nil then
			--	  DeleteEntity(loot[i].prop)
				--end
	--ClearPedTasksImmediately(playerPed)
    --   FreezeEntityPosition(playerPed, false)
			if has_pickaxe == true then
				--DrawText3Ds(locations.coords.x, locations.coords.y, locations.coords.z, Config.Locales.loottext)
				Stonesmining(ClientRocks, i)
				mineActive = true
			elseif has_pickaxe == false then
			ESX.ShowNotification(source,Config.Locales.lowmoney)
			end
		   ----print(ClientRocks[i].spawn)
end
end
elseif locations.spawn < 60 then
      DeleteEntity(Objects[i])
	  Objects[i] = nil
end
end
end
end
end)

Citizen.CreateThread(function() 
    while true do

				TriggerServerEvent("hyon_mining:get_rock")
				TriggerServerEvent("hyon_mining:get_exchange")
				------print("Itt kuldi el a szervernek hogy kell rock")
				Citizen.Wait(1000)
	end
end)

RegisterNetEvent("hyon_mining:create_rock")
AddEventHandler("hyon_mining:create_rock", function(rock)
	local playerPed  = GetPlayerPed()
	------print("teszt")
	for k,v in pairs(rock) do
		------print("teszt2")
		--if ClientRocks[k].coords ~= v.coords and ClientRocks[k].spawn ~= v.spawn then
	ClientRocks[k] = {}
	ClientRocks[k] = {coords = v.coords, spawn = v.spawn}
	------print(ClientRocks[k].coords, ClientRocks[k].spawn)
		--end
	end
	Citizen.Wait(1000)
end)

RegisterNetEvent("hyon_mining:create_exchanges")
AddEventHandler("hyon_mining:create_exchanges", function(exchange)
	local playerPed  = GetPlayerPed()
	------print("teszt")
	for k,v in pairs(exchange) do
	--print(stoneprice)
		if v.item == "stone" then
		stoneprice = v.price
		elseif v.item == "iron_bar" then
		ironprice = v.price
		elseif v.item == "silver_bar" then
		silverprice = v.price
		elseif v.item == "gold_bar" then
		goldprice = v.price
		elseif v.item == "diamond" then
		diamondprice = v.price
		end
	end
	Citizen.Wait(1000)
end)


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(22)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370

end

function Stonesmining(ClientRocks, i)
    Citizen.CreateThread(function()
        local impacts = 0
        while impacts < 3 do
            Citizen.Wait(0)
		    local ped = PlayerPedId()
            local plyCoords = GetEntityCoords(ped)
            local FrontStone = GetEntityForwardVector(ped)
            local x, y, z = table.unpack(plyCoords + FrontStone * 1.0)
            if not HasNamedPtfxAssetLoaded("core") then
	           RequestNamedPtfxAsset("core")
	             while not HasNamedPtfxAssetLoaded("core") do
		         Wait(0)
	           end
            end
            if impacts == 0 then
               pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
               AttachEntityToEntity(pickaxe, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, true, true, false, true, 1, true)
            end
			FreezeEntityPosition(ped, true)
            LoadDict('melee@large_wpn@streamed_core')
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot',  8.0, 8.0, -1, 80, 0, 0, 0, 0)
            Citizen.Wait(730)
 --           TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.5, "mining", 35.10)
            UseParticleFxAssetNextCall("core")
            effect = StartParticleFxLoopedAtCoord("ent_amb_stoner_landing",x, y, z-1.0, 0.0, 0.0, 0.0, 1.6, false, false, false, false)
            Citizen.Wait(1000)
            StopParticleFxLooped(effect, 0)
            Citizen.Wait(1500)
            ClearPedTasks(ped)
			FreezeEntityPosition(ped, false)
            impacts = impacts+1
            --print('mining loop->',impacts)
            if impacts == 3 then
               impacts = 0
			   TriggerServerEvent('lootmoney', ClientRocks, i)
               DeleteEntity(pickaxe)
               mineActive = false
               break
            end
        end
    end)
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

Citizen.CreateThread(function() 
    while true do
	local playerPed = PlayerPedId()
    local mycords = GetEntityCoords(PlayerPedId())
	local dist = #(mycords - Config.SmelterCoord)
	
	if dist < 2 then
	   DrawText3Ds(Config.SmelterCoord.x, Config.SmelterCoord.y, Config.SmelterCoord.z, Config.Locales.smelttext)
       if IsControlJustReleased(0,38) then
	   OpenSmelterMenu()
		end
	end
	Citizen.Wait(3)
	end
end)

local Elements = {
  {
   icon="fa fa-arrow-right",
   title= Config.Locales.smeltirontitle,
   description= Config.Locales.smeltirondesc,
  },
    {
   icon="fa fa-arrow-right",
   title= Config.Locales.smeltsilvertitle,
   description= Config.Locales.smeltsilverdesc,
  },
    {
   icon="fa fa-arrow-right",
   title= Config.Locales.smeltgoldtitle,
   description= Config.Locales.smeltgolddesc,
  },
}

function OpenSmelterMenu()
ESX.OpenContext("center" , Elements, 
  function(menu,element)
            local ply = PlayerPedId();
            local coords = GetEntityCoords(ply, true)
			local ore = nil

  if element.title == Config.Locales.smeltirontitle then
	    ESX.CloseContext()
	local amount_ore = KeyboardInput(Config.Locales.smeltingamount, "", 7)
	local ore = "iron_ore"
    if tonumber(amount_ore) then
	    FreezeEntityPosition(ply, true)
		TaskStartScenarioInPlace(ply, 'PROP_HUMAN_BUM_BIN', 0, true)
		Wait(5000)
		ClearPedTasks(ply)
		FreezeEntityPosition(ply, false)
        TriggerServerEvent("hyon_mining:smelting", player, ore, amount_ore)
    end
  end

  if element.title == Config.Locales.smeltsilvertitle then
     ESX.CloseContext()
	local amount_ore = KeyboardInput(Config.Locales.smeltingamount, "", 7)
	local ore = "silver_ore"
    if tonumber(amount_ore) then
	    FreezeEntityPosition(ply, true)
		TaskStartScenarioInPlace(ply, 'PROP_HUMAN_BUM_BIN', 0, true)
		Wait(5000)
		ClearPedTasks(ply)
		FreezeEntityPosition(ply, false)
        TriggerServerEvent("hyon_mining:smelting", player, ore, amount_ore)
    end
	
  end
  
    if element.title == Config.Locales.smeltgoldtitle then
	    ESX.CloseContext()
	local amount_ore = KeyboardInput(Config.Locales.smeltingamount, "", 7)
	local ore = "gold_ore"
    if tonumber(amount_ore) then
	    FreezeEntityPosition(ply, true)
		TaskStartScenarioInPlace(ply, 'PROP_HUMAN_BUM_BIN', 0, true)
		Wait(5000)
		ClearPedTasks(ply)
		FreezeEntityPosition(ply, false)
        TriggerServerEvent("hyon_mining:smelting", player, ore, amount_ore)
    end

  end

  ESX.CloseContext()
end, function(menu)
end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

CreateThread(function()
    local pedmodel = GetHashKey(Config.Ped)
	local g = 0
	local t = 10
    RequestModel(pedmodel)
	while not HasModelLoaded(pedmodel) do
		Citizen.Wait(1)
	end
       local npc = CreatePed(1, pedmodel, Config.Shop.x, Config.Shop.y, Config.Shop.z-1, 30.64, false, true)
        FreezeEntityPosition(npc, true)
        SetEntityHeading(npc, 30.64)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
	    while true do
		local playerPed = PlayerPedId()
		local mycords = GetEntityCoords(PlayerPedId())
		local dist = #(mycords - Config.Shop)
			if dist < 2 then
			DrawText3Ds(Config.Shop.x, Config.Shop.y, Config.Shop.z+1, Config.Locales.shoptext)
			if IsControlJustReleased(0,38) then
			OpenShopMenu()
		end
	end
	Citizen.Wait(3)
		end
end)


function OpenShopMenu()
local shopElements = {
   {
   icon="fa fa-arrow-right",
   title= Config.Locales.shoppaxetitle,
   description= Config.Locales.shoppaxedesc,
  },
   {
   icon="fa fa-sack-dollar",
   title= Config.Locales.shopstonetitle,
   description= Config.Locales.shopstonedesc.. stoneprice,
  },
   {
   icon="fa fa-sack-dollar",
   title= Config.Locales.shopironbartitle,
   description= Config.Locales.shopirondesc.. ironprice,
  },
   {
   icon="fa fa-sack-dollar",
   title= Config.Locales.shopsilverbartitle,
   description= Config.Locales.shopsilverdesc.. silverprice,
  },
   {
   icon="fa fa-sack-dollar",
   title= Config.Locales.shopgoldbartitle,
   description= Config.Locales.shopgolddesc.. goldprice,
  },
  {
   icon="fa fa-sack-dollar",
   title= Config.Locales.shopdiamondtitle,
   description= Config.Locales.shopdiamonddesc.. diamondprice,
  },
}
ESX.OpenContext("center" , shopElements, 
  function(menu,element)
            local ply = PlayerPedId();
            local coords = GetEntityCoords(ply, true)

  if element.title == Config.Locales.shoppaxetitle then
	    ESX.CloseContext()
	local amount = 1
    if tonumber(amount) then
        TriggerServerEvent("hyon_mining:pickaxebuy", player, amount)
    end
  end
  if element.title == Config.Locales.shopstonetitle then
	    ESX.CloseContext()
	local amount_bar = KeyboardInput(Config.Locales.sellamount, "", 7)
	local bar = "stone"
    if tonumber(amount_bar) then
        TriggerServerEvent("hyon_mining:sellbar", player, bar, amount_bar, stoneprice)
    end
  end
   if element.title == Config.Locales.shopironbartitle then
	    ESX.CloseContext()
	local amount_bar = KeyboardInput(Config.Locales.sellamount, "", 7)
	local bar = "iron_bar"
    if tonumber(amount_bar) then
        TriggerServerEvent("hyon_mining:sellbar", player, bar, amount_bar, ironprice)
    end
  end
   if element.title == Config.Locales.shopsilverbartitle then
	    ESX.CloseContext()
	local amount_bar = KeyboardInput(Config.Locales.sellamount, "", 7)
	local bar = "silver_bar"
    if tonumber(amount_bar) then
        TriggerServerEvent("hyon_mining:sellbar", player, bar, amount_bar, silverprice)
    end
  end
   if element.title == Config.Locales.shopgoldbartitle then
	    ESX.CloseContext()
	local amount_bar = KeyboardInput(Config.Locales.sellamount, "", 7)
	local bar = "gold_bar"
    if tonumber(amount_bar) then
        TriggerServerEvent("hyon_mining:sellbar", player, bar, amount_bar, goldprice)
    end
  end
   if element.title == Config.Locales.shopdiamondtitle then
	    ESX.CloseContext()
	local amount_bar = KeyboardInput(Config.Locales.sellamount, "", 7)
	local bar = "diamond"
    if tonumber(amount_bar) then
        TriggerServerEvent("hyon_mining:sellbar", player, bar, amount_bar, diamondprice)
    end
  end

  ESX.CloseContext()
end, function(menu)
end)
end