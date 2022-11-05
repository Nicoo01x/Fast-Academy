Config = {}

Config.AllLogs = false											-- Enable/Disable All Logs Channel
Config.postal = false  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "Fast Academy - Argentina" 							    -- Bot Username
Config.avatar = "https://cdn.discordapp.com/attachments/954665817025421362/1037227938921332736/logo.png"				-- Bot Avatar
Config.communtiyName = "Fast Academy"						-- Icon top of the embed
Config.communtiyLogo = "https://cdn.discordapp.com/attachments/954665817025421362/1037227938921332736/logo.png"		-- Icon top of the embed
Config.FooterText = "Logs FastAcademy 2022 by facujas"					-- Footer text for the embed
Config.FooterIcon = "https://cdn.discordapp.com/attachments/954665817025421362/1037227938921332736/logo.png"			-- Footer icon for the embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.InlineFields = true			-- set to false if you don't want the player details next to each other

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.license = true				-- set to false to disable license in the logs
Config.IP = true					-- set to false to disable IP in the logs

-- Change color of the default embeds here
-- It used Decimal or Hex color codes. They will both work.
Config.BaseColors ={		-- For more info have a look at the docs: https://docs.prefech.com
	chat = "#A1A1A1",				-- Chat Message
	joins = "#3AF241",				-- Player Connecting
	leaving = "#F23A3A",			-- Player Disconnected
	deaths = "#000000",				-- Shooting a weapon
	shooting = "#2E66F2",			-- Player Died
	resources = "#EBEE3F",			-- Resource Stopped/Started	
}


Config.webhooks = {		-- For more info have a look at the docs: https://docs.prefech.com
	all = "https://discord.com/api/webhooks/1037216118554767451/TH8TSq5gThbBg5pE1RfhJOh5fQDJazW4FKvxE90vcbHnwah58lrYWDtsc0TTK0t-rR3S",																												-- All logs will be send to this channel
	chat = "https://discord.com/api/webhooks/1035718706799595521/j-fCcOAtiCVKFdvwsBt-N9mRaIdlTEkd9w7fsJ_2FyDQbjqkXwb6iTVW9UPPgVS1x7qb",		-- Chat Message
	joins = "https://discord.com/api/webhooks/1035718387088756746/KdG6lA5d8wHwyN6mwYML-wkA66rIBlwWtmqVpZt7VWSe8795zGVtyR9prhzwvXVYW2Me",		-- Player Connecting
	leaving = "https://discord.com/api/webhooks/1035718387088756746/KdG6lA5d8wHwyN6mwYML-wkA66rIBlwWtmqVpZt7VWSe8795zGVtyR9prhzwvXVYW2Me",	-- Player Disconnected
	deaths = "https://discord.com/api/webhooks/1036404850264645712/5VaW23A7gstQx4-OQcEzdcEnc3vn90w_vYYVZ9LrZYImnAgS3NbGpxUWVt1jaUwkGyxX",	-- Shooting a weapon
	shooting = "https://discord.com/api/webhooks/1035718533822300240/PA2iwoA7s3_UJuYEMuZN4_AmqZIfnqm8rfKPSdpfyU1pi8DPrvYFXu4cttVaEr4pCiFz",	-- Player Died
	resources = "https://discord.com/api/webhooks/1037216486533648395/-IkoYOnpBE8I8hq5ooRguhaYtoc6diqJwWOjgG8lhP5dl50SqX3IW7f1sE2N3mcnodWV",																											-- Resource Stopped/Started	
}

Config.TitleIcon = {			-- For more info have a look at the docs: https://docs.prefech.com
	chat = "💬",				-- Chat Message
	joins = "📥",				-- Player Connecting
	leaving = "📤",				-- Player Disconnected
	deaths = "💀",				-- Shooting a weapon
	shooting = "🔫",			-- Player Died
	resources = "🔧",			-- Resource Stopped/Started	
}

Config.Plugins = {
	--["PluginName"] = {color = "#FFFFFF", icon = "🔗", webhook = "DISCORD_WEBHOOK"},
	["NameChange"] = {color = "#03fc98", icon = "🔗", webhook = "DISCORD_WEBHOOK"},
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.3.0"
