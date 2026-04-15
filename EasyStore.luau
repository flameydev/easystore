--// MODULE
local EasyStore = {}

--// SERVICES
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

--// DATA STORES
local Store = DataStoreService:GetDataStore("Data")

-- Safety check
local function check()
	if not pcall(function() DataStoreService:GetDataStore("ServiceCheck"):SetAsync("Test", true) end) then
		error("❗ Studio Access to API Services is not allowed. Enable it in Experience Settings > Security.")
	end
end

--// MAIN

--Save Data for a Player. Returns success (bool), errorMsg (string), if any.
--playerOrId: Pass through a Player object or the Player's UserId (Player.UserId)
--data: The table with the data you want to save
function EasyStore:Save(playerOrId:Player|number, data:{any})
	check()
	local id = playerOrId.UserId or playerOrId
	
	local success, errorMsg = pcall(function()
		Store:SetAsync(id, {Data = data})
	end)
	if not success then
		warn("⚠️ Failed to save data for", id .. ". See error message below:")
		warn(errorMsg)
	else
		print("✅ Successfully saved provided data for", id)
	end
	
	--[[local returningData = {
		successful = success,
		saved = data,
		errorMessage = errorMsg
	}]]
	
	return success, errorMsg
end

--Load Data for a Player. Returns data (table), errMsg (string), if an error occured.
--playerOrId: Pass through a Player object or the Player's UserId (Player.UserId)
function EasyStore:Load(playerOrId:Player|number)
	check()
	local id = playerOrId.UserId or playerOrId
	local data
	
	local success, errMsg = pcall(function()
		data = Store:GetAsync(id)
	end)
	if not success then
		warn("⚠️ Failed to get saved data for", id .. ". See error message below:")
		warn(errMsg)
	else
		print("✅ Successfully got saved data for", id)
	end
	
	return data, errMsg
end

return EasyStore
