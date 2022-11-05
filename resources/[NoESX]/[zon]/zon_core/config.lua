Config = {}
Config.Locale = "en"


-- Config.blips = {
--   {title="Teletransportes", colour=5, id=36, x = -167.3201, y= 1596.099, z= 7.171445},
--   {title="Tienda de ROPA", colour=5, id=73, x = -155.587, y=  1591.163, z= 7.174175},
--   {title="Comisaria", colour=5, id=60, x = 123.9701, y=1025.606,z= 14.75047},
-- --{title="OTRO", colour=5, id=36, x = 130.12, y= -1055.3, z= 29.19},
-- }

-- FFA

Config.marker = vector3(-167.3685, 1579.136, 7.125111)

Config.Teleports = {
  standart = {
      dimension = 0,
      spawnpoints = {
          vector3(569.94, 2796.82, 42.02)
      }
  },
  sg = {
      dimension = 30,
      spawnpoints = {
          vector3(1629.33, 2496.81, 44.56),
          vector3(1622.69, 2561.02, 44.56),
          vector3(1762.322, 2542.14, 44.56),
          vector3(1723.89, 2494.1, 45.56),
          vector3(1692.69, 2471.34, 45.57),
          vector3(1619.16, 2570.29, 45.56),
          vector3(1758.79, 2518.91, 45.56),
          vector3(1616.79, 2524.93, 44.56)
      }
  },
  fr = {
      dimension = 33,
      spawnpoints = {
          vector3(2409.35, 3034.52, 48.21),
          vector3(2361.51, 3132.52, 48.21),
          vector3(2420.44, 3154.43, 48.21),
          vector3(2423.35, 3112.52, 48.21),
          vector3(2352.51, 3063.52, 48.21),
          vector3(2427.44, 3082.43, 48.21)
      }
  },
  wp = {
      dimension = 31,
      spawnpoints = { 
        vector3(1477.549, 1176.342, 114.33),
        vector3(1462.949, 1162.905, 114.3044),
        vector3(1443.434, 1156.439, 114.3343),
        vector3(1441.789, 1148.691, 114.3343),
        vector3(1462.539, 1147.539, 114.3343),
        vector3(1473.223, 1140.451, 114.3342),
        vector3(1463.632, 1130.658, 114.3314),
        vector3(1438.235, 1136.35, 114.4102),
        

      }
  },
  pr = {
      dimension = 32,
      spawnpoints = {
          vector3(-37.96309, 1606.901, 15.3417),
          vector3(-33.15714, 1619.607, 18.62539),
          vector3(-53.17935, 1636.742, 18.62538),
          vector3(-55.78865, 1660.599, 18.62534),
          vector3(-54.79036, 1685.068, 18.62509),
          vector3(-25.96165, 1690.5, 18.62504),
          vector3(-26.92818, 1666.103, 18.62524)
      }
  }
}

Config.Vehiculos =  {
    {label = "2f2fgtr34", model = "2f2fgtr34"},
    {label = "2f2fgts", model = "2f2fgts"},
    {label = "E82f2fmk49", model = "2f2fmk4"},
    {label = "E82f2fmle79", model = "2f2fmle7"},
    {label = "ff4wrx", model = "2f2fmle7"},
    {label = "fnf4r34", model = "2f2fmle7"},
    {label = "fnflan", model = "fnflan"},
    {label = "fnfmits", model = "fnfmits"},
    {label = "fnfmk4", model = "fnfmk4"},
    {label = "fnfrx7", model = "fnfrx7"},
    {label = "190e", model = "190e"},
    {label = "ap2", model = "ap2"},
    {label = "bmwe", model = "bmwe"},
    {label = "e89", model = "e89"},
    {label = "silvia3", model = "silvia3"},
    {label = "16m5", model = "16m5"},
    {label = "aaq4", model = "aaq4"},
    {label = "cayenne", model = "cayenne"},
    {label = "350z", model = "350z"},
    {label = "350z2", model = "350z2"},
    {label = "750li", model = "750li"},
    {label = "2017chiron", model = "2017chiron"},
    {label = "2018zl1", model = "2018zl1"},
    {label = "2019chiron", model = "2019chiron"},
    {label = "a45", model = "a45"},
    {label = "aaq4", model = "aaq4"},
    {label = "ap2", model = "ap2"},
    {label = "c10ss", model = "c10ss"},
    {label = "BMWe90", model = "BMWe90"},
    {label = "cayenne", model = "cayenne"},
}

Config.Peds = {
    -- {
  {
       name = '8',
       id = 133,
       pos = vector3(-859.3222, -407.4655, 35.63925),
       h = 200.9299,
       color = 2,
       scale = 0.8,
       model = 'g_m_m_chicold_01',
       animation = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
       label = '~p~Menu FFA',
       comando = 'menuFFA'
    },
  
    {
  
       name = '1',
       id = 133,
       pos = vector3(-845.2467, -408.5801, 35.63927),
       h = 143.05,
       color = 2,
       scale = 0.8,
       model = 'a_m_m_beach_01',
       label = '~p~Menu PRACTICE',
       animation = 'WORLD_HUMAN_STAND_IMPATIENT',
       comando = 'menu1VS1'
  
    },
    {
  
       name = '1',
       id = 133,
       pos = vector3(-858.3964, -435.7493, 35.63992),
       h =  1.4615,
       color = 2,
       scale = 0.8,
       model = 'a_m_y_acult_02',
       label = '~p~Menu ACADEMY',
       animation = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
       comando = "academy"
  
    },
    {
        name = '5',
        id = 204,
        pos = vector3(-441.2578, 1595.3043, 358.4680),
        h = 236.2204,
        color = 2,
        scale = 0.8,
        model = 's_m_y_prismuscl_01',
        animation = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
    },
  
--     {
  
--       name = '1',
--       id = 133,
--       pos = vector3(407.158, -355.2148, 46.8231),
--       h =  80.94897,
--       color = 2,
--       scale = 0.8,
--       model = 'a_m_y_runner_01',
--       animation = 'WORLD_HUMAN_CAR_PARK_ATTENDANT',
--       comando = "drift"
  
--    },
  
  }