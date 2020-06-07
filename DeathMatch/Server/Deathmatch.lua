-- Deathmatch class

--[[
DeathMatch = {}
    DeathMatch.Global = {} -- array of all player in the game
    DeathMatch.BlueTeam = {} -- array of the player in BlueTeam
    DeathMatch.RedTeam = {} -- array of the player in RedTeam
    DeathMatch.Score = {} -- array of score {blueteam,redteam}
    DeathMatch.Spectator = {} -- Array of people that are spectator
    DeathMatch.MapData = {} -- Data of the map like spawn point for each team , map name etc.... (will be extract from JSON file)

--]]

DeathMatch = {
    Global = {},
    BlueTeam = {},
    RedTeam = {},
    Spectator = {},
    Score = {},
    MapData = {}
}
DeathMatch.mt = {}

DeathMatch.New = function()
    local dm = {}
    setmetatable(dm,DeathMatch.mt)
    return dm
end

DeathMatch.DataExtract = function(data) -- data is the json file to get for example test.json
--Get map name, Waitingarea , respawn point, time , weather , ScoreLimit and save all in MapData
end


DeathMatch.Load = function()

    for k,v in pair(NanosWorld:GetPlayer()) do

        if(v:GetValue("WaitingDeathmatchGame")) then
        --Putting them in the Global array
        v:SetValue("IsInADeathmatchGame", true)
        end
        -- split them from the temporary array to the team get the length of the array and divide by 2 half will go on each time and if its unpair the last will go on a random team
        -- spawn them on a respawn point ( and in the correct dimension when it will be implemented)
        World.SetTime(DeathMatch.MapData.time.hour,DeathMatch.MapData.time.minute)
        World.SetWeather(DeathMatch.MapData.weather)
        -- freeze them 
        -- load UI
        -- Spawn weapon to each (will be replace by a shop later)
        -- do the countdown before starting and when it is over launch DeathMatch.Start()
        -- Add this lobby in the global variable index.lua server
        -- Reset to all player the data value and add the ID of the game
    end
end

DeathMatch.Start = function()
-- unfreeze the player
-- start the countdown for the end of the game (end game by time or if a time arrive at the score limit)
end

DeathMatch.End = function()
    --Freeze everyone
    -- Announce the winner team (and the stats of the game)
    -- wait 5-10 sec so everyone can see the score and stats
    -- Remove everyone from the deathmatch lobby and put them in the waitinglobby
    for k,v in pair(DeathMatch.Global) do
        v:SetValue("IsInADeathmatchGame", false)
        v:SetValue("WaitingDeathmatchGame", true)
     end
    -- Destroy this lobby in the global variable index.lua server
end

DeathMatch.UpdateUI = function ()
    -- loop through every client to update the score and timer
    for k,v in pair(DeathMatch.Global) do
        
     end


end

DeathMatch.CheckVictory = function ()
    if(DeathMatch.Score[0] == DeathMatch.MapData.ScoreLimit or DeathMatch.Score[1] == DeathMatch.MapData.ScoreLimit) then
    -- DeathMatch.End()
    end
end