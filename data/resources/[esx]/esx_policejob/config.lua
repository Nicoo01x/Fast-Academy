Config                            = {}

Config.DrawDistance               = 5
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 5.5, y = 5.5, z = 5.5 }
Config.MarkerColor                = { r = 255, g = 0, b = 0}

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = false -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = false -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = false -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = { -- COMPLETA

		Blip = {
			Coords  = vector3(627.6447, 1.723592, 82.787),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 38
		},

		Cloakrooms = {
			vector3(619.2595, 11.8927, 81.7979),
		},

		Armories = {
			vector3(-239.0892, 840.7930, 168.7767),
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
					{ coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0 },
					{ coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0 },
					{ coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{ coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
					{ coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(632.19, 90.24, 90.24)
		},

	},

	PALETO = { -- NO COMPLETA

		Blip = {
			Coords  = vector3(-441, 6018, 33.0),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.0,
			Colour  = 38
		},

		Cloakrooms = {
			vector3(-456.24, 6013.56, 31.72)
		},

		Armories = {
			vector3(-426.29, 5998.17, 31.72)
		},

		Vehicles = {
			{
				Spawner = vector3(-449.86, 6003.13, 31.39),
				InsideShop = vector3(-477.02, 6025.08, 30.34),
				SpawnPoints = {
					{ coords = vector3(-455.67, 6001.81, 31.34), heading = 90.0, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-462.67, 5994.43, 31.25),
				InsideShop = vector3(-476.34, 5987, 31.44),
				SpawnPoints = {
					{ coords = vector3(-476.34, 5987, 31.44), heading = 90.0, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(-446.13, 6014.15, 36.69)
		},

	},

	SANDY = { -- COMPLETA

		Blip = {
			Coords  = vector3(1853.94, 3678.081, 33.805),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.0,
			Colour  = 38
		},

		Cloakrooms = {
			vector3(1859.322, 3695.32, 34.236)
		},

		Armories = {
			vector3(1862.422, 3689.574, 34.263)
		},

		Vehicles = {
			{
				Spawner = vector3(1867.758, 3698.662, 33.515),
				InsideShop = vector3(1873.497, 3689.075, 33.578),
				SpawnPoints = {
					{ coords = vector3(1873.497, 3689.075, 33.578), heading = 90.0, radius = 6.0 },
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1860.89, 3654.721, 34.008),
				InsideShop = vector3(1867.313, 3647.349, 35.823),
				SpawnPoints = {
					{ coords = vector3(1867.313, 3647.349, 35.823), heading = 90.0, radius = 6.0 }
				}
			},
		},

		BossActions = {
			vector3(1852.127, 3690.528, 34.267)
		}

	}

}

Config.AuthorizedWeapons = {
	Recluta = { -- AGENTE
	{ weapon = 'WEAPON_PISTOL_MK2', price = 0 },
	{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
    { weapon = 'WEAPON_SMG', price = 0 },
    { weapon = 'WEAPON_ASSAULTRIFLE', price = 0 },
	{ weapon = 'WEAPON_CARBINERIFLE', price = 0 },	
	},

	Oficiall = { -- CABO
	{ weapon = 'WEAPON_PISTOL_MK2', price = 0 },
	{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
    { weapon = 'WEAPON_SMG', price = 0 },
    { weapon = 'WEAPON_ASSAULTRIFLE', price = 0 },
	{ weapon = 'WEAPON_CARBINERIFLE', price = 0 },		
	},

	Oficialll = { -- CABO 1ro
	{ weapon = 'WEAPON_PISTOL_MK2', price = 0 },
	{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
    { weapon = 'WEAPON_SMG', price = 0 },
    { weapon = 'WEAPON_ASSAULTRIFLE', price = 0 },
	{ weapon = 'WEAPON_CARBINERIFLE', price = 0 },		
	},
	
	Oficiallll = { -- SARGENTO
	{ weapon = 'WEAPON_PISTOL_MK2', price = 0 },
	{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
    { weapon = 'WEAPON_SMG', price = 0 },
    { weapon = 'WEAPON_ASSAULTRIFLE', price = 0 },
	{ weapon = 'WEAPON_CARBINERIFLE', price = 0 },			
	},
	
	Sargentol = { -- SARGENTO 1ro
	{ weapon = 'WEAPON_PISTOL_MK2', price = 0 },
	{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
    { weapon = 'WEAPON_SMG', price = 0 },
    { weapon = 'WEAPON_ASSAULTRIFLE', price = 0 },
	{ weapon = 'WEAPON_CARBINERIFLE', price = 0 },		
	},

	Sargentoll = { -- SUB OFICIAL AUXILIAR
	{ weapon = 'WEAPON_PISTOL_MK2', price = 0 },
	{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
    { weapon = 'WEAPON_SMG', price = 0 },
    { weapon = 'WEAPON_ASSAULTRIFLE', price = 0 },
	{ weapon = 'WEAPON_CARBINERIFLE', price = 0 },		
	},

	Instructor = { -- SUB OFICIAL MAYOR
	{ weapon = 'WEAPON_PISTOL_MK2', price = 0 },
	{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
    { weapon = 'WEAPON_SMG', price = 0 },
    { weapon = 'WEAPON_ASSAULTRIFLE', price = 0 },
	{ weapon = 'WEAPON_CARBINERIFLE', price = 0 },		
	},

	Chief = { -- SUB INSPECTOR
	{ weapon = 'WEAPON_PISTOL_MK2', price = 0 },
	{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
    { weapon = 'WEAPON_SMG', price = 0 },
    { weapon = 'WEAPON_ASSAULTRIFLE', price = 0 },
	{ weapon = 'WEAPON_CARBINERIFLE', price = 0 },					
	},

	lieutenant = { -- INSPECTOR
		{ weapon = 'WEAPON_PISTOL_MK2', price = 300 },     -- PISTOLA 
		{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 900 },  	-- ESCOPETA	
		{ weapon = 'WEAPON_PUMPSHOTGUN_MK2', price = 900 },        -- ESCOPETA
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 4500 },        -- SNIPER
		{ weapon = 'WEAPON_COMBATPDW', components = { nil, 1000, nill, 1000, 1000, 1000 }, price = 4500 },    -- TEC 9 
		{ weapon = 'WEAPON_SMG', components = {nil, nil,nil,1000,1000 }, price = 1000 },		        -- SMG
		{ weapon = 'WEAPON_CARBINERIFLE',components = { nil,1000,nil,1000,1000,nil,1000 }, price = 1600 },		-- RIFLE		
		{ weapon = 'WEAPON_NIGHTSTICK', price = 500 },          -- ACCESORIOS	
		{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },          -- ACCESORIOS
		{ weapon = 'WEAPON_STUNGUN', price = 500 },             -- ACCESORIOS
		{ weapon = 'WEAPON_BZGAS', price = 500 },          -- GAS
		{ weapon = 'GADGET_PARACHUTE', price = 1000 }  -- Paracaidas  
	},

	chef = { -- COMISARIO
		{ weapon = 'WEAPON_PISTOL_MK2', price = 300 },     -- PISTOLA 
		{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 900 },  	-- ESCOPETA	
		{ weapon = 'WEAPON_PUMPSHOTGUN_MK2', price = 900 },        -- ESCOPETA
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 4500 },        -- SNIPER
		{ weapon = 'WEAPON_COMBATPDW', components = { nil, 1000, nill, 1000, 1000, 1000 }, price = 4500 },    -- TEC 9 
		{ weapon = 'WEAPON_SMG', components = {nil, nil,nil,1000,1000 }, price = 1000 },		        -- SMG
		{ weapon = 'WEAPON_CARBINERIFLE',components = { nil,1000,nil,1000,1000,nil,1000 }, price = 1600 },		-- RIFLE			
		{ weapon = 'WEAPON_NIGHTSTICK', price = 500 },          -- ACCESORIOS	
		{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },          -- ACCESORIOS
		{ weapon = 'WEAPON_STUNGUN', price = 500 },             -- ACCESORIOS	
		{ weapon = 'WEAPON_BZGAS', price = 500 },          -- GAS
		{ weapon = 'GADGET_PARACHUTE', price = 1000 }  -- Paracaidas  
	},

	boss = { -- COMISARIO GENERAL
		{ weapon = 'WEAPON_PISTOL_MK2', price = 300 },     -- PISTOLA 
		{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 900 },  	-- ESCOPETA	
		{ weapon = 'WEAPON_PUMPSHOTGUN_MK2', price = 900 },        -- ESCOPETA
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 4500 },        -- SNIPER
		{ weapon = 'WEAPON_COMBATPDW', components = { nil, 1000, nill, 1000, 1000, 1000 }, price = 4500 },    -- TEC 9 
		{ weapon = 'WEAPON_SMG', components = {nil, nil,nil,1000,1000 }, price = 1000 },		        -- SMG
		{ weapon = 'WEAPON_CARBINERIFLE',components = { nil,1000,nil,1000,1000,nil,1000 }, price = 1600 },		-- RIFLE		
		{ weapon = 'WEAPON_NIGHTSTICK', price = 500 },          -- ACCESORIOS	
		{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },          -- ACCESORIOS
		{ weapon = 'WEAPON_STUNGUN', price = 500 },             -- ACCESORIOS	
		{ weapon = 'WEAPON_BZGAS', price = 500 },          -- GAS
		{ weapon = 'GADGET_PARACHUTE', price = 1000 }  -- Paracaidas  
	}
}

Config.AuthorizedVehicles = {
	Shared = { -- TODOS
		{ model = 'policeb', label = 'Moto Individual', price = 1 }
	},

	recruit = { -- AGENTE

	},

	cabo = { -- CABO
		{ model = 'police', label = 'Patrulla #1', price = 1 }
	},

	cabo1 = { -- CABO 1ro
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 }
	},

	sargento = { -- SARGENTO
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 }
	},

	sargento1 = { -- SARGENTO 1ro
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 },
		{ model = 'riot', label = 'Patrulla SWAT', price = 1 }
	},

	subaux = { -- SUB OFICIAL AUXILIAR
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 },
		{ model = 'riot', label = 'Patrulla SWAT', price = 1 }
	},

	officer = { -- SUB OFICIAL MAYOR
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 },
		{ model = 'riot', label = 'Patrulla SWAT', price = 1 }
	},

	sergeant = { -- SUB INSPECTOR
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 },
		{ model = 'riot', label = 'Patrulla SWAT', price = 1 }
	},

	intendent = { -- INSPECTOR
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 },
		{ model = 'riot', label = 'Patrulla SWAT', price = 1 }
	},

	lieutenant = { -- SUB COMISARIO	
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 },
		{ model = 'riot', label = 'Patrulla SWAT', price = 1 }
	},

	chef = { -- COMISARIO
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 },
		{ model = 'riot', label = 'Patrulla SWAT', price = 1 }
	},

	boss = { -- COMISARIO GENERAL
		{ model = 'police', label = 'Patrulla #2', price = 1 },
		{ model = 'police2', label = 'Patrulla #3', price = 1 },
		{ model = 'police3', label = 'Patrulla #4', price = 1 },
		{ model = 'riot', label = 'Patrulla SWAT', price = 1 }
	}
}

Config.AuthorizedHelicopters = {
	recruit = {}, -- AGENTE (no permitido)

	cabo = {}, -- CABO (no permitido)

	cabo1 = {}, -- CABO 1ro (no permitido)

	sargento = { -- SARGENTO
		{ model = 'polmav', label = 'H-145', livery = 0, price = 500 }, -- H-145
		{ model = 'valkyrie', label = 'Sicorsky', livery = 0, price = 500 } -- Sicorsky
	},

	sargento1 = { -- SARGENTO 1ro
		{ model = 'polmav', label = 'H-145', livery = 0, price = 500 }, -- H-145
		{ model = 'valkyrie', label = 'Sicorsky', livery = 0, price = 500 } -- Sicorsky
	},

	subaux = { -- SUB OFICIAL AUXILIAR
		{ model = 'polmav', label = 'H-145', livery = 0, price = 500 }, -- H-145
		{ model = 'valkyrie', label = 'Sicorsky', livery = 0, price = 500 } -- Sicorsky
	},

	officer = { -- SUB OFICIAL MAYOR
		{ model = 'polmav', label = 'H-145', livery = 0, price = 500 }, -- H-145
		{ model = 'valkyrie', label = 'Sicorsky', livery = 0, price = 500 } -- Sicorsky
	},

	sergeant = { -- SUB INSPECTOR
		{ model = 'polmav', label = 'H-145', livery = 0, price = 500 }, -- H-145
		{ model = 'valkyrie', label = 'Sicorsky', livery = 0, price = 500 } -- Sicorsky
	},

	intendent = { -- INSPECTOR
		{ model = 'polmav', label = 'H-145', livery = 0, price = 500 }, -- H-145
		{ model = 'valkyrie', label = 'Sicorsky', livery = 0, price = 500 } -- Sicorsky
	},

	lieutenant = { -- SUB COMISARIO
		{ model = 'polmav', label = 'H-145', livery = 0, price = 500 }, -- H-145
		{ model = 'valkyrie', label = 'Sicorsky', livery = 0, price = 500 } -- Sicorsky
	},

	chef = { -- COMISARIO
		{ model = 'polmav', label = 'H-145', livery = 0, price = 15000 }, -- H-145
		{ model = 'valkyrie', label = 'Sicorsky', livery = 0, price = 500 } -- Sicorsky
	},

	boss = { -- COMISARIO GENERAL
		{ model = 'polmav', label = 'H-145', livery = 0, price = 500 }, -- H-145
		{ model = 'valkyrie', label = 'Sicorsky', livery = 0, price = 500 } -- Sicorsky
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = { -- RECLUTA
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 271,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['earrings_2'] = 0
		}
	},
	cabo_wear = { -- OFICIAL I
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 271,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['earrings_2'] = 0
		}
	},
	cabo1_wear = { -- OFICIAL II
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 271,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['earrings_2'] = 0
		}
	},
	sargento_wear = { -- OFICIAL III
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 1,
			['torso_1'] = 271,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['earrings_2'] = 0
		}
	},
	sargento1_wear = { -- SARGENTO 1 
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 271,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['earrings_2'] = 0
		}
	},
	subaux_wear = { -- SARGENTO 2
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 1,
			['torso_1'] = 271,  ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['earrings_2'] = 0
		}
	},
	officer_wear = { -- CHIEF
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 271,  ['torso_2'] = 7,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 73,   ['torso_2'] = 2,
			['decals_1'] = -1,   ['decals_2'] = 3,
			['arms'] = 33,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 29,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['earrings_2'] = 0
		}
	},
	sergeant_wear = { 
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 271,   ['torso_2'] = 7,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 73,   ['torso_2'] = 2,
			['decals_1'] = -1,   ['decals_2'] = 3,
			['arms'] = 33,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 29,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['earrings_2'] = 0
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 111,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 73,   ['torso_2'] = 2,
			['decals_1'] = -1,   ['decals_2'] = 3,
			['arms'] = 33,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 29,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['earrings_2'] = 0
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 1,
			['torso_1'] = 13,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 38,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['earrings_2'] = 0
		},
		female = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 27,   ['torso_2'] = 0,
			['decals_1'] = -1,   ['decals_2'] = 3,
			['arms'] = 33,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 29,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['earrings_2'] = 0
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 1,
			['torso_1'] = 13,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 38,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['earrings_2'] = 0
		},
		female = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 27,   ['torso_2'] = 0,
			['decals_1'] = -1,   ['decals_2'] = 3,
			['arms'] = 33,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 29,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['earrings_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 1,
			['torso_1'] = 13,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 37,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 38,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['earrings_2'] = 0
		},
		female = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 27,   ['torso_2'] = 0,
			['decals_1'] = -1,   ['decals_2'] = 3,
			['arms'] = 33,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 29,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['earrings_2'] = 0
		}
	},
	unitgang_wear = { -- ROPA UNIT GANG
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 271,   ['torso_2'] = 8,
			['decals_1'] = -1,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 43,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 30,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	swat_wear = { -- ROPA UNIDAD SWAT
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 271,   ['torso_2'] = 9,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 43,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 30,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	gomf_wear = { -- ROPA GOMF
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 50,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 43,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 30,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	francotirador_wear = { -- ROPA FRANCOTIRADOR
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 50,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 43,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 30,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	chaleco_ciudad = { -- CHALECO CIUDAD
		male = {
			['bproof_1'] = 7,  ['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1,
		}
	},
	bullet_wear = { -- CHALECO ANTIBALAS (invisible)
		male = {
		},
		female = {
		}
	},
	gilet_wear = { -- CHALECO TRANSITO
		male = {
			['bproof_1'] = 7,  ['bproof_2'] = 1,
		},
		female = {
			['bproof_1'] = 7,  ['bproof_2'] = 1
		}
	}
}

--[[ COSAS A AGREGAR:
 Comprar municion en la armeria --]]