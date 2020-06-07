-- Deathmatch class

DeathMatch = {
    Global = {}, -- array of all player in the game
    BlueTeam = {}, -- array of the player in BlueTeam
    RedTeam = {}, -- array of the player in RedTeam
    Spectator = {}, -- Array of people that are spectator
    Score = {}, -- array of score {blueteam,redteam}
    MapData = {} -- Data of the map like spawn point for each team , map name etc.... (will be extract from JSON file)
}


DeathMatch.__index = DeathMatch 
function DeathMatch:new( dimension )
    if DeathMatchGlobal[ dimension ] then return DeathMatchGlobal[ dimension ] end -- if the table exists return it

    local new_instance = {
        dimension = dimension -- whenever we need to need in which dimension it is, we can
    }

    setmetatable( new_instance, DeathMatch )
    DeathMatchGlobal[ dimension ] = new_instance -- save the instance to the global table

    return new_instance
end


-- For load the map
-- DeathMatch:DataExtract( Package:Require ("./Maps/" .. map_name .. ".lua") )

function DeathMatch:DataExtract (data) -- data is the json file to get for example test.json
--Get map name, Waitingarea , respawn point, time , weather , ScoreLimit and save all in MapData
self.MapData = data
end


function DeathMatch:Load ()

    for k,v in pairs(NanosWorld:GetPlayer()) do

        if(v:GetValue("WaitingDeathmatchGame")) then
        --Putting them in the Global array
        v:SetValue("IsInADeathmatchGame", true)
        end
        -- split them from the temporary array to the team get the length of the array and divide by 2 half will go on each time and if its unpair the last will go on a random team
        -- spawn them on a respawn point ( and in the correct dimension when it will be implemented)
        World.SetTime(self.MapData.time.hour,self.MapData.time.minute)
        World.SetWeather(self.MapData.weather)
        -- freeze them 
        -- load UI
        -- Spawn weapon to each (will be replace by a shop later)
        -- do the countdown before starting and when it is over launch DeathMatch.Start()
        -- Add this lobby in the global variable index.lua server
        -- Reset to all player the data value and add the ID of the game
    end
end

function DeathMatch:Start ()
-- unfreeze the player
-- start the countdown for the end of the game (end game by time or if a time arrive at the score limit)
end

function DeathMatch:End ()
    --Freeze everyone
    -- Announce the winner team (and the stats of the game)
    -- wait 5-10 sec so everyone can see the score and stats
    -- Remove everyone from the deathmatch lobby and put them in the waitinglobby
    for k,v in pairs(self.Global) do
        v:SetValue("IsInADeathmatchGame", false)
        v:SetValue("WaitingDeathmatchGame", true)
     end
    -- Destroy this lobby in the global variable index.lua server
end

function DeathMatch:UpdateUI ()
    -- loop through every client to update the score and timer
    for k,v in pairs(self.Global) do
        
     end


end

function DeathMatch:CheckVictory ()
    if(self.Score[0] == self.MapData.ScoreLimit or self.Score[1] == self.MapData.ScoreLimit) then
    -- DeathMatch.End()
    end
end