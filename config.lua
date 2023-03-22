
-- Every rocks are synced

Config = {}

Config.RockSpawn = 20 -- Rock respawn time in minute

Config.miningblip = true -- Use Mining Blip true/false

Config.smelterblip = true -- Use Smelter Blip true/false

Config.shopblip = true -- Use Shop Blip true/false

Config.MiningBlipCoord = vector3(2773.48,2856.08,35.44) -- Mining Blip Coord

Config.SmelterCoord = vector3(1110.96,-2007.84,31.04) -- Smelter Blip Coord

Config.Shop = vector3(2707.08,2777.48,37.88) -- Miner Shop Coord

Config.PickaxePrice = 200 -- Pickaxe price

Config.Ped = "cs_floyd" -- Shop Ped

Config.Loots = {
			{
				item = "coal",
				chance = 50,
			},
			{
				item = "iron_ore",
				chance = 50,
			},
			{
				item = "silver_ore",
				chance = 40,
			},
			{
				item = "gold_ore",
				chance = 30,
			},
			{
				item = "diamond",
				chance = 10,
			},
}

Config.Exchange_rate_refresh_time = 1 -- In hour (If you use 24 hours the exchange rate(current price) will refresh every 24 hours)

Config.Exchange_rate = {		--random price between min and max
			{
			item = "stone",
			min = 1,			--Random min price 
			max = 5,			--Random max price
			},
			{
			item = "iron_bar",
			min = 400,
			max = 600,
			},
			{
			item = "silver_bar",
			min = 800,
			max = 1000,
			},
			{
			item = "gold_bar",
			min = 1500,
			max = 2500,
			},
			{
			item = "diamond",
			min = 4000,
			max = 6000,
			},
	
}

Config.Locales = {
bliptext = "Mining",
smelterbliptext = "Smelter",
loottext = "Press ~g~E~s~ to start mining",
nopickaxe = "~r~You don't have pickaxe!~s~",
smelttext = "Press ~g~E~s~ to start Smelting",
smeltirontitle = "Iron Bar",
smeltirondesc = "You need 1x Iron Ore and 1x Coal",
smeltsilvertitle = "Silver Bar",
smeltsilverdesc = "You need 1x Silver Ore and 3x Coal",
smeltgoldtitle = "Gold Bar",
smeltgolddesc = "You need 1x Gold Ore and 5x Coal",
noores = "~r~You don't have enough ore(s)!~s~",
smelted ="You have ~g~successfully~s~ smelted the ore(s)",
smeltingamount = "How many bars do you want to make?",
shoptext = "Press ~g~E~s~ to Open Shop",
shoppaxetitle = "Buy Pickaxe",
shoppaxedesc = "Price: ".. Config.PickaxePrice,
shoppaxeamount= "How many Pickaxe do you want to buy?",
nomoney = "~r~You don't have enough money!~s~",
shopstonetitle = "Stone",
shopironbartitle = "Iron Bar",
shopsilverbartitle = "Silver Bar",
shopgoldbartitle = "Gold Bar",
shopdiamondtitle = "Diamond",
shopstonedesc = "Current Price: ",
shopirondesc = "Current Price: ",
shopsilverdesc = "Current Price: ",
shopgolddesc = "Current Price: ",
shopdiamonddesc = "Current Price: ",
sellamount = "How many pieces do you want to sell?",
nosell = "~r~You don't have enough item(s)!~s~",
sell ="You have ~g~successfully~s~ selled the item(s)",
nofreespace  = "You don't have enough free space",
}

Config.Rocks = {  -- Rocks coordinates
{coords = vector3(2765.56, 2839.0, 36.28)},
{coords = vector3(2772.4, 2855.08, 35.44)},
{coords = vector3(2790.68, 2850.32, 36.4)},
{coords = vector3(2777.56, 2875.2, 35.16)},
{coords = vector3(2766.8,2900.56,36.16)},
{coords = vector3(2745.76,2926.52,36.2)},
{coords = vector3(2722.96,2932.84,37.72)},
{coords = vector3(2689.12,2941.32,36.64)},
{coords = vector3(2687.84,2978.84,36.44)},
{coords = vector3(2701.2,2999.28,35.4)},
{coords = vector3(2715.12,2977.12,36.72)},
{coords = vector3(2754.64,2985.84,38.56)},
{coords = vector3(2882.16,2829.44,54.76)},
{coords = vector3(2940.0,2854.12,56.88)},
{coords = vector3(2979.12,2840.16,55.88)},
{coords = vector3(3013.88,2779.88,53.56)},
{coords = vector3(3013.88,2763.8,54.24)},
{coords = vector3(2989.76,2726.76,56.12)},
{coords = vector3(2948.2,2717.56,54.48)},
{coords = vector3(2937.56,2779.4,39.28)},
{coords = vector3(2954.2,2776.92,39.8)},
{coords = vector3(2969.44,2782.0,39.0)},
{coords = vector3(2968.04,2800.8,41.32)},
{coords = vector3(2991.88,2785.24,43.76)},
{coords = vector3(2951.32,2738.96,44.28)},
{coords = vector3(3036.96,2730.92,63.84)},
{coords = vector3(3054.84,2732.12,64.12)},
{coords = vector3(3051.16,2722.32,63.08)},
{coords = vector3(2958.2,2676.52,64.04)},
{coords = vector3(2917.84,2701.36,73.2)},
{coords = vector3(2944.16,2674.28,76.0)},
{coords = vector3(3000.24,2695.16,74.88)},
{coords = vector3(3059.84,2799.52,77.2)},
{coords = vector3(3003.32,2897.56,60.72)},
{coords = vector3(3017.68,2894.04,73.72)},
{coords = vector3(2977.04,2910.52,70.68)},
{coords = vector3(2984.6,2952.16,79.4)},

}