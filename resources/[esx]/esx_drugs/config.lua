Config = {}

Config.Locale = 'es'

Config.Delays = {
	WeedProcessing = 1000 * 7
}

Config.DrugDealerItems = {
	marijuana = 1100
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000}
}

Config.GiveBlack = false -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(-428.2504, 1141.734, 325.9042), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(228.4007, 765.8398, 204.7808), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 100.0},
	DrugDealer = {coords = vector3(-440.7675, 1595.286, 358.468), name = _U('blip_drugdealer'), color = 6, sprite = 378},
	
}