--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX				= nil
inMenu			= true
local showblips	= true
local atbank	= false
local bankMenu	= true
local banks = {
	{name = "Banco", id = 108, x = 150.266, y = -1040.203, z = 29.374},
	{name = "Banco", id = 108, x = -1212.980, y = -330.841, z = 37.787},
	{name = "Banco", id = 108, x = -2962.582, y = 482.627, z = 15.703},
	{name = "Banco", id = 108, x = -112.202, y = 6469.295, z = 31.626},
	{name = "Banco", id = 108, x = 314.187, y = -278.621, z = 54.170},
	{name = "Banco", id = 108, x = -351.534, y = -49.529, z = 49.042},
	{name = "Banco", id = 108, x = 1175.0643310547, y = 2706.6435546875, z = 38.094036102295}
}

local atms = {
	--{name = "ATM", id = 277, x = -386.733, y = 6045.953, z = 31.501},
}
--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================

--===============================================
--==           Base ESX Threading              ==
--===============================================
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj)
			ESX = obj
		end)

		Citizen.Wait(0)
	end
end)

local isNearATM = false
if bankMenu then
	Citizen.CreateThread(
		function()
			while true do
				s = 1000
				if nearBank() or isNearATM then
					s = 0
					ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para acceder a la cuenta ~b~")

					if IsControlJustPressed(1, 38) then
						inMenu = true
						SetNuiFocus(true, true)
						SendNUIMessage({type = "openGeneral"})
						TriggerServerEvent("bank:balance")
						local ped = PlayerPedId()
					end
				end

				if IsControlJustPressed(1, 322) then
					inMenu = false
					SetNuiFocus(false, false)
					SendNUIMessage({type = "close"})
				end
				Wait(s)
			end
		end
	)
	Citizen.CreateThread(
		function()
			while true do
				Wait(1000)
				isNearATM = nearATM()
			end
		end
	)
end

--===============================================
--==             Map Blips	                   ==
--===============================================
-- Citizen.CreateThread(
-- function()
-- 	if showblips then
-- 		for k, v in ipairs(banks) do
-- 			local blip = AddBlipForCoord(v.x, v.y, v.z)
-- 			SetBlipSprite(blip, v.id)
-- 			SetBlipDisplay(blip, 4)
-- 			SetBlipScale(blip, 0.7)
-- 			SetBlipColour(blip, 31)
-- 			SetBlipAsShortRange(blip, true)
-- 			BeginTextCommandSetBlipName("STRING")
-- 			AddTextComponentString(tostring(v.name))
-- 			EndTextCommandSetBlipName(blip)
-- 		end
-- 	end
-- end)

RegisterNetEvent("currentbalance1")
AddEventHandler(
	"currentbalance1",
	function(balance)
		local id = PlayerId()
		local playerName = GetPlayerName(id)

		SendNUIMessage(
			{
				type = "balanceHUD",
				balance = balance,
				player = playerName
			}
		)
	end
)

RegisterNUICallback(
	"deposit",
	function(data)
		TriggerServerEvent("bank:depospainsit", tonumber(data.amount))
		TriggerServerEvent("bank:balance")
	end
)

RegisterNUICallback(
	"withdrawl",
	function(data)
		TriggerServerEvent("bank:witspainhdraw", tonumber(data.amountw))
		TriggerServerEvent("bank:balance")
	end
)

RegisterNUICallback(
	"balance",
	function()
		TriggerServerEvent("bank:balance")
	end
)

RegisterNetEvent("balance:back")
AddEventHandler(
	"balance:back",
	function(balance)
		SendNUIMessage({type = "balanceReturn", bal = balance})
	end
)

RegisterNUICallback(
	"transfer",
	function(data)
		TriggerServerEvent("bank:transspainfer", data.to, data.amountt)
		TriggerServerEvent("bank:balance")
	end
)

RegisterNetEvent("bank:result")
AddEventHandler(
	"bank:result",
	function(type, message)
		SendNUIMessage({type = "result", m = message, t = type})
	end
)

RegisterNUICallback(
	"NUIFocusOff",
	function()
		inMenu = false
		SetNuiFocus(false, false)
		SendNUIMessage({type = "closeAll"})
	end
)

function nearBank()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc["x"], playerloc["y"], playerloc["z"], true)

		if distance <= 2 then
			currentAtmLocation = vector3(search.x, search.y, search.z -1)
			return true
		end
	end
end

local atms = {
	"prop_atm_01",
	"prop_atm_02",
	"prop_atm_03",
	"prop_fleeca_atm"
}

currentAtmLocation = nil

function nearATM()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)
	for i = 1, #atms do
		local nearestatm = GetClosestObjectOfType(playerloc, 2.0, GetHashKey(atms[i]), false)
		if DoesEntityExist(nearestatm) then
			local atmLocation = GetEntityCoords(nearestatm)
			local atmHead = GetEntityHeading(nearestatm)
			local distance = GetDistanceBetweenCoords(playerloc.x, playerloc.y, playerloc.z, atmLocation.x, atmLocation.y, atmLocation.z, true)
			if distance < 2.0 then
				currentAtmLocation = atmLocation
				return true
			end
		end
	end
	return false
end