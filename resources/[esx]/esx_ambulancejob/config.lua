Config = {}

Config.DrawDistance = 20.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).

Config.Marker = {
    type = 1,
    x = 1.5,
    y = 1.5,
    z = 0.5,
    r = 102,
    g = 0,
    b = 102,
    a = 100,
    rotate = false
}

Config.ReviveReward = 1000
Config.AntiCombatLog = true
Config.LoadIpl = false

Config.Locale = 'es'

Config.EarlyRespawnTimer = 60000--60000 * 2
Config.BleedoutTimer = 60000 * 0

Config.EnablePlayerManagement = false

Config.RemoveWeaponsAfterRPDeath = true
Config.RemoveCashAfterRPDeath = true
Config.RemoveItemsAfterRPDeath = true

Config.EarlyRespawnFine = false
Config.EarlyRespawnFineAmount = 5000

Config.RespawnPoint = {coords = vector3(-167.3623, 1579.118, 7.125113), heading = 48.5}

-- Config.Efectos = {
--     ['Efecto1'] = {
--         HasNamedPtfxAssetLoaded = "scr_tplaces",
--         RequestNamedPtfxAsset = "scr_tplaces",
--         UseParticleFxAssetNextCall = "scr_tplaces",
--         StartNetworkedParticleFxNonLoopedAtCoord = "scr_tplaces_team_swap"
--     },
--     ['Efecto2'] = {
--         HasNamedPtfxAssetLoaded = "scr_indep_fireworks",
--         RequestNamedPtfxAsset = "scr_indep_fireworks",
--         UseParticleFxAssetNextCall = "scr_indep_fireworks",
--         StartNetworkedParticleFxNonLoopedAtCoord = "scr_indep_firework_trailburst"
--     },
--     ['Efecto3'] = {
--         HasNamedPtfxAssetLoaded = "scr_josh3",
--         RequestNamedPtfxAsset = "scr_josh3",
--         UseParticleFxAssetNextCall = "scr_josh3",
--         StartNetworkedParticleFxNonLoopedAtCoord = "scr_josh3_explosion"
--     },
--     ['Efecto4'] = {
--         HasNamedPtfxAssetLoaded = "scr_indep_fireworks",
--         RequestNamedPtfxAsset = "scr_indep_fireworks",
--         UseParticleFxAssetNextCall = "scr_indep_fireworks",
--         StartNetworkedParticleFxNonLoopedAtCoord = "scr_indep_firework_burst_spawn"
--     },
--     ['Efecto5'] = {
--         HasNamedPtfxAssetLoaded = "proj_xmas_firework",
--         RequestNamedPtfxAsset = "proj_xmas_firework",
--         UseParticleFxAssetNextCall = "proj_xmas_firework",
--         StartNetworkedParticleFxNonLoopedAtCoord = "scr_firework_xmas_spiral_burst_rgw"
--     },
--     ['Efecto6'] = {
--         HasNamedPtfxAssetLoaded = "wpn_musket",
--         RequestNamedPtfxAsset = "wpn_musket",
--         UseParticleFxAssetNextCall = "wpn_musket",
--         StartNetworkedParticleFxNonLoopedAtCoord = "muz_musket_ng"
--     },
--     ['Efecto7'] = {
--         HasNamedPtfxAssetLoaded = "veh_khanjali",
--         RequestNamedPtfxAsset = "veh_khanjali",
--         UseParticleFxAssetNextCall = "veh_khanjali",
--         StartNetworkedParticleFxNonLoopedAtCoord = "muz_xm_khanjali_railgun"
--     },
-- }

Config.Hospitals = {

    CentralLosSantos = {

        Blip = {
            coords = vector3(299.3143, -573.4945, 43.24829),
            sprite = 61,
            scale = 0.6,
            color = 0
        },

        AmbulanceActions = {vector3(301.56, -599.12, 42.28)},

        Pharmacies = {vector3(310.72, -565.68, 42.28)},

        Vehicles = {
            {
                Spawner = vector3(299.68, -573.99, 43.16),
                InsideShop = vector3(294.03, -605.14, 43.21),
                Marker = {
                    type = 36,
                    x = 1.0,
                    y = 1.0,
                    z = 1.0,
                    r = 100,
                    g = 50,
                    b = 200,
                    a = 100,
                    rotate = true
                },
                SpawnPoints = {
                    {
                        coords = vector3(285.58, -570.77, 43.14),
                        heading = 227.6,
                        radius = 4.0
                    },
                    {
                        coords = vector3(285.58, -570.77, 43.14),
                        heading = 227.6,
                        radius = 4.0
                    },
                    {
                        coords = vector3(285.58, -570.77, 43.14),
                        heading = 227.6,
                        radius = 6.0
                    }
                }
            }
        },

        Helicopters = {
            {
                Spawner = vector3(317.5, -1449.5, 46.5),
                InsideShop = vector3(305.6, -1419.7, 41.5),
                Marker = {
                    type = 34,
                    x = 1.5,
                    y = 1.5,
                    z = 1.5,
                    r = 100,
                    g = 150,
                    b = 150,
                    a = 100,
                    rotate = true
                },
                SpawnPoints = {
                    {
                        coords = vector3(313.5, -1465.1, 46.5),
                        heading = 142.7,
                        radius = 10.0
                    },
                    {
                        coords = vector3(299.5, -1453.2, 46.5),
                        heading = 142.7,
                        radius = 10.0
                    }
                }
            }
        },

        FastTravels = {
            {
                From = vector3(2, 2, 2),
                To = {coords = vector3(272.8, -1358.8, 23.5), heading = 0.0},
                Marker = {
                    type = 1,
                    x = 2.0,
                    y = 2.0,
                    z = 0.5,
                    r = 102,
                    g = 0,
                    b = 102,
                    a = 100,
                    rotate = false
                }
            }, {
                From = vector3(275.3, -1361, 23.5),
                To = {coords = vector3(295.8, -1446.5, 28.9), heading = 0.0},
                Marker = {
                    type = 1,
                    x = 2.0,
                    y = 2.0,
                    z = 0.5,
                    r = 102,
                    g = 0,
                    b = 102,
                    a = 100,
                    rotate = false
                }
            }, {
                From = vector3(247.3, -1371.5, 23.5),
                To = {coords = vector3(333.1, -1434.9, 45.5), heading = 138.6},
                Marker = {
                    type = 1,
                    x = 1.5,
                    y = 1.5,
                    z = 0.5,
                    r = 102,
                    g = 0,
                    b = 102,
                    a = 100,
                    rotate = false
                }
            }, {
                From = vector3(335.5, -1432.0, 45.50),
                To = {coords = vector3(249.1, -1369.6, 23.5), heading = 0.0},
                Marker = {
                    type = 1,
                    x = 2.0,
                    y = 2.0,
                    z = 0.5,
                    r = 102,
                    g = 0,
                    b = 102,
                    a = 100,
                    rotate = false
                }
            }, {
                From = vector3(234.5, -1373.7, 20.9),
                To = {coords = vector3(320.9, -1478.6, 28.8), heading = 0.0},
                Marker = {
                    type = 1,
                    x = 1.5,
                    y = 1.5,
                    z = 1.0,
                    r = 102,
                    g = 0,
                    b = 102,
                    a = 100,
                    rotate = false
                }
            }, {
                From = vector3(317.9, -1476.1, 28.9),
                To = {coords = vector3(238.6, -1368.4, 23.5), heading = 0.0},
                Marker = {
                    type = 1,
                    x = 1.5,
                    y = 1.5,
                    z = 1.0,
                    r = 102,
                    g = 0,
                    b = 102,
                    a = 100,
                    rotate = false
                }
            }
        },

        FastTravelsPrompt = {
            {
                From = vector3(237.4, -1373.8, 26.0),
                To = {coords = vector3(251.9, -1363.3, 38.5), heading = 0.0},
                Marker = {
                    type = 1,
                    x = 1.5,
                    y = 1.5,
                    z = 0.5,
                    r = 102,
                    g = 0,
                    b = 102,
                    a = 100,
                    rotate = false
                },
                Prompt = _U('fast_travel')
            }, {
                From = vector3(256.5, -1357.7, 36.0),
                To = {coords = vector3(235.4, -1372.8, 26.3), heading = 0.0},
                Marker = {
                    type = 1,
                    x = 1.5,
                    y = 1.5,
                    z = 0.5,
                    r = 102,
                    g = 0,
                    b = 102,
                    a = 100,
                    rotate = false
                },
                Prompt = _U('fast_travel')
            }
        }

    }
}

Config.AuthorizedVehicles = {
    car = {
        ambulance = {{model = 'ambulance', price = 0}},

        doctor = {{model = 'ambulance', price = 0}},

        chief_doctor = {{model = 'ambulance', price = 0}},

        boss = {{model = 'ambulance', price = 0}}
    },

    helicopter = {
        ambulance = {},

        doctor = {{model = 'buzzard2', price = 0}},

        chief_doctor = {
            {model = 'buzzard2', price = 0},
            {model = 'seasparrow', price = 0}
        },

        boss = {
            {model = 'buzzard2', price = 0},
            {model = 'seasparrow', price = 0}
        }
    }
}
