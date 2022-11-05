Config = {}
Config.Locale = 'es'

Config.Marker = {
	r = 255, g = 0, b = 0, a = 100,  -- red color
	x = 0.5, y = 0.5, z = 0.5,      -- tiny, cylinder formed circle
	DrawDistance = 20.0, Type = 21    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 2
Config.TimerBeforeNewRob    = 300 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 150   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = false -- give black money? If disabled it will give cash instead

Stores = {
	["fleca_2"] = {
		position = { x = 311.2018, y = -284.427, z = 54.500 },
		reward = math.random(10000, 20000),
		nameOfStore = "Banco Flecca",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0
	},		
	["fleca_3"] = {
		position = { x = -353.757, y = -55.2763, z = 49.436 },
		reward = math.random(10000, 20000),
		nameOfStore = "Banco Flecca",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0
	},		
	["fleca_4"] = {
		position = { x = -1210.89, y = -336.662, z = 36.781 },
		reward = math.random(10000, 20000),
		nameOfStore = "Banco Flecca",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0
	},	
	["fleca_4"] = {
		position = { x = -2956.56, y = 481.7006, z = 16.697 },
		reward = math.random(10000, 20000),
		nameOfStore = "Banco Flecca",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0
	},	
	["Life Invader"] = {
		position = { x = -1082.32,  y = -247.68,  z = 38.05 },
		reward = math.random(10000, 20000),
		nameOfStore = "Life Invader",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0
	},
	["Antena"] = {
		position = { x = 780.51,  y = 1296.89,  z = 361.77 },
		reward = math.random(10000, 20000),
		nameOfStore = "Antena",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0
	},
	["Axion"] = {
		position = { x = 2572.21,  y = 479.83,  z = 109.00 },
		reward = math.random(10000, 20000),
		nameOfStore = "Axion",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0
	},
	["Cementerio"] = {
		position = { x = -1679.42, y = -264.365, z = 52.300 },
		reward = math.random(10000, 20000),
		nameOfStore = "Cementerio",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0
	},
	["Universidad"] = {
		position = { x = -1637.03,  y = 180.45,  z = 62.10 },
		reward = math.random(10000, 20000),
		nameOfStore = "Universidad",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0
	},
	["Anfiteatro"] = {
		position = { x = 185.48,  y = 1214.52,  z = 225.92 },
		reward = math.random(10000, 20000),
		nameOfStore = "Anfiteatro",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Corral"] = {
		position = { x = 1292.57,  y = 321.63,  z = 82.3 },
		reward = math.random(10000, 20000),
		nameOfStore = "Corral",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Golf"] = {
		position = { x = -1366.09,  y = 56.76,  z = 54.4 },
		reward = math.random(10000, 20000),
		nameOfStore = "Golf",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Horny's"] = {
		position = { x = 1245.567, y = -346.508, z = 69.350 },
		reward = math.random(10000, 20000),
		nameOfStore = "Horny's",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Micheal"] = {
		position = { x = -817.749, y = 177.8719, z = 72.522 },
		reward = math.random(10000, 20000),
		nameOfStore = "Casa Micheal",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Obras"] = {
		position = { x = 9.612022, y = -398.537, z = 39.786 },
		reward = math.random(10000, 20000),
		nameOfStore = "Obras",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Joyeria"] = {
		position = { x = -628.874, y = -235.537, z = 38.357 },
		reward = math.random(10000, 20000),
		nameOfStore = "Joyeria",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Concesionario"] = {
		position = { x = -38.9623, y = -1110.38, z = 26.700 },
		reward = math.random(10000, 20000),
		nameOfStore = "Concesionario",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Ayuntamiento"] = {
		position = { x = -545.108, y = -204.069, z = 38.515 },
		reward = math.random(10000, 20000),
		nameOfStore = "Ayuntamiento",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Museo"] = {
		position = { x = -2290.95, y = 365.5130, z = 174.90 },
		reward = math.random(10000, 20000),
		nameOfStore = "Museo",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Weazel"] = {
		position = { x=-599.9939, y=-930.5457, z=23.8649 },
		reward = math.random(10000, 20000),
		nameOfStore = "Weazel News",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["3x1"] = {
		position = { x=-709.6834, y=-904.0453, z=19.2156 },
		reward = math.random(10000, 20000),
		nameOfStore = "Tienda 3x1",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["MegaMall"] = {
		position = { x=54.9675, y=-1738.7284, z=29.9268 },
		reward = math.random(10000, 20000),
		nameOfStore = "Mega Mall",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Bebidas"] = {
		position = { x=1126.9854, y=-980.1343, z=45.7058 },
		reward = math.random(10000, 20000),
		nameOfStore = "Bebidas",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["MC Donalds"] = {
		position = { x=90.4918, y=297.9494, z=110.5302 },
		reward = math.random(10000, 20000),
		nameOfStore = "MC Donalds",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Bomberos"] = {
		position = { ['x'] = 321.39, ['y'] = -1627.95, ['z'] = 32.74 },
		reward = math.random(10000, 20000),
		nameOfStore = "Bomberos",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Carguero"] = {
		position = { ['x'] = 1244.59, ['y'] = -3004.44, ['z'] = 9.72, },
		reward = math.random(10000, 20000),
		nameOfStore = "Carguero",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Robs"] = {
		position = { ['x'] = -2959.66, ['y'] =  387.16, ['z'] = 14.35, },
		reward = math.random(10000, 20000),
		nameOfStore = "Robs",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Carniceria"] = {
		position = { ['x'] = 968.52, ['y'] = -2160.06, ['z'] = 29.90, },
		reward = math.random(10000, 20000),
		nameOfStore = "Carniceria",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Deposito"] = {
		position = { ['x'] = 1569.64, ['y'] = -2129.59, ['z'] = 78.74, },
		reward = math.random(10000, 20000),
		nameOfStore = "Deposito",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["Teatro"] = {
		position = { ['x'] = -1007.02, ['y'] = -486.86, ['z'] = 40.38, },
		reward = math.random(10000, 20000),
		nameOfStore = "Teatro",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	["GPostal"] = {
		position = { ['x'] = -3170.25, ['y'] = 1034.15, ['z'] = 21.20, },
		reward = math.random(10000, 20000),
		nameOfStore = "GPostal",
		secondsRemaining = 80, -- seconds
		lastRobbed = 0 
	},
	
}
