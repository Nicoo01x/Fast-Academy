--------------------------
-- Chat de radio InGame --
--     por Jougito      --
--------------------------

Config              = {}

Config.Command      = "r" -- Comando para la radio
Config.rCommand     = "rr" -- Comando para la radio conjunta Policía - EMS
Config.rgCommand     = "rg" -- Comando para la radio conjunta Policía - GNA

Config.JouBot       = false -- Habilita si el comando es registrado por el script JouBot

Label               = {}

Label.Police        = "Radio PFA" -- Título Policía
Label.Ambulance     = "Radio SAME" -- Título EMS
Label.Taxi          = "Radio Taxi" -- Título Taxi
Label.Sheriff       = "Radio Gendarmeria" -- Título Badu-Bar
Label.Mechanic      = "Radio Benny's" -- Título Mecánico
Label.Casino        = "Radio Casino" -- Título Casino
Label.WeazelNews    = "Radio Weazel News" -- Título Weazel News
Label.SecuroServ    = "Radio Securo-Serv" -- Título Securo-Serv
Label.PoliceEMS     = "Radio PFA Y SAME" -- Título Policía - EMS
Label.PoliceGNA     = "Radio PFA Y GNA" -- Título Policía - EMS

Color               = {}

Color.Police        = { 0, 150, 255 } -- Color Policía (Azul)
Color.Ambulance     = { 50, 255, 0 } -- Color EMS (Verde)
Color.Taxi          = { 255, 235, 0 } -- Color Taxi (Amarillo)
Color.Sheriff       = { 0, 255, 155 } -- Color Badu-Bar (Verde-Azul)
Color.Mechanic      = { 200, 100, 0 } -- Color Mecánico (Marrón)
Color.Casino        = { 255, 155, 0 } -- Color Casino (Naranja)
Color.WeazelNews    = { 255, 0, 0 } -- Color Weazel News (Rojo)
Color.SecuroServ    = { 255, 0, 150 } -- Color Securo-Serv (Rosa)
Color.PoliceEMS     = { 0, 255, 155 } -- Color Policía - EMS (Verde-Azul)
Color.PoliceGNA     = { 0, 255, 155 } -- Color Policía - EMS (Verde-Azul)

Jobs                = {}

Jobs.State          = "state" -- Trabajo Estado
Jobs.Police         = "police" -- Trabajo Policía
Jobs.Ambulance      = "ambulance" -- Trabajo EMS
Jobs.Taxi           = "taxi" -- Trabajo Taxi
Jobs.Sheriff        = "sheriff" -- Trabajo Badu-Bar
Jobs.Mechanic       = "mechanic" -- Trabajo Mecánico
Jobs.Casino         = "casino" -- Trabajo Casino
Jobs.WeazelNews     = "wnews" -- Trabajo Weazel News
Jobs.SecuroServ     = "secuserv" -- Trabajo Securo-Serv

ESX                 = nil
PlayerData          = {}
