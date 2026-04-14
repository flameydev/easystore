--// MODULE
local EasyStore = {}

--// SERVICES
local DataStoreService = game:GetService("DataStoreService")

local apiEnabled, _ = pcall(function()
    DataStoreService:GetDataStore("ServiceCheck"):SetAsync("Test", true)
end)

if not apiEnabled then
    warn("Studio Access to API Services (DataStore) not allowed. Check Game Settings > Security.")
end


--// AUTOSAVE
local DoAutoSave = true
local AutoSaveIntervals = 120 -- seconds

--unfinished